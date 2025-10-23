-- Cria o banco de dados principal
CREATE DATABASE db_gestao;

-- Conecte-se a este banco de dados antes de executar as próximas etapas
-- psql -U admin -d db_gestao -h localhost -p 5432 (terminal)

-- Criação das tabelas de conteúdo
CREATE TABLE Visao (
    id BIGINT PRIMARY KEY,
    comando VARCHAR
);

CREATE TABLE Consulta (
    id BIGINT PRIMARY KEY,
    query VARCHAR
);

CREATE TABLE Objetivo (
    id BIGINT PRIMARY KEY,
    solucaoInsert VARCHAR,
    descricao VARCHAR,
    nivel INT
);

CREATE TABLE Capitulo (
    id BIGINT PRIMARY KEY,
    id_topico BIGINT,
    id_nivel BIGINT,
    id_visao BIGINT,
    descricao VARCHAR,
    numero INT,
    titulo VARCHAR,
    nivelMaximo INT,
    FOREIGN KEY (id_topico) REFERENCES Objetivo(id),
    FOREIGN KEY (id_nivel) REFERENCES Objetivo(id),
    FOREIGN KEY (id_visao) REFERENCES Visao(id)
);

CREATE TABLE Desafio (
    id BIGINT PRIMARY KEY,
    nome VARCHAR,
    descricao VARCHAR,
    id_capitulo BIGINT,
    FOREIGN KEY (id_capitulo) REFERENCES Capitulo(id)
);

CREATE TABLE capitulo_visao (
    id BIGINT PRIMARY KEY,
    id_capitulo BIGINT,
    id_visao BIGINT,
    FOREIGN KEY (id_capitulo) REFERENCES Capitulo(id),
    FOREIGN KEY (id_visao) REFERENCES Visao(id)
);

-- Tabela para o sistema de auditoria (Log)
CREATE TABLE Log (
    id SERIAL PRIMARY KEY,
    table_name VARCHAR(255) NOT NULL,
    operation VARCHAR(10) NOT NULL,
    old_data TEXT,
    new_data TEXT,
    changed_by VARCHAR(255) NOT NULL,
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Função de auditoria
CREATE OR REPLACE FUNCTION log_changes()
RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'DELETE') THEN
        INSERT INTO Log (table_name, operation, old_data, changed_by)
        VALUES (TG_TABLE_NAME, 'DELETE', OLD::text, current_user);
        RETURN OLD;
    ELSIF (TG_OP = 'UPDATE') THEN
        INSERT INTO Log (table_name, operation, old_data, new_data, changed_by)
        VALUES (TG_TABLE_NAME, 'UPDATE', OLD::text, NEW::text, current_user);
        RETURN NEW;
    ELSIF (TG_OP = 'INSERT') THEN
        INSERT INTO Log (table_name, operation, new_data, changed_by)
        VALUES (TG_TABLE_NAME, 'INSERT', NEW::text, current_user);
        RETURN NEW;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Criação dos triggers para as tabelas principais
CREATE TRIGGER visao_audit AFTER INSERT OR UPDATE OR DELETE ON Visao FOR EACH ROW EXECUTE FUNCTION log_changes();
CREATE TRIGGER consulta_audit AFTER INSERT OR UPDATE OR DELETE ON Consulta FOR EACH ROW EXECUTE FUNCTION log_changes();
CREATE TRIGGER objetivo_audit AFTER INSERT OR UPDATE OR DELETE ON Objetivo FOR EACH ROW EXECUTE FUNCTION log_changes();
CREATE TRIGGER capitulo_audit AFTER INSERT OR UPDATE OR DELETE ON Capitulo FOR EACH ROW EXECUTE FUNCTION log_changes();
CREATE TRIGGER desafio_audit AFTER INSERT OR UPDATE OR DELETE ON Desafio FOR EACH ROW EXECUTE FUNCTION log_changes();