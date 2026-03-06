-- =============================================
-- GESTÃO DDL v2.1 - Compatible with Game Challenge Models (1:N Desafio:Capitulo)
-- =============================================

-- =============================================
-- CORE CHALLENGE TABLES
-- =============================================

-- Desafio = Challenge (the game/mission card)
CREATE TABLE IF NOT EXISTS Desafio (
    id BIGSERIAL PRIMARY KEY,
    titulo VARCHAR NOT NULL,
    descricao VARCHAR NOT NULL,
    -- xp_recompensa INT NOT NULL DEFAULT 0,
    tempo_estimado VARCHAR,
    taxa_conclusao DECIMAL(5,2) DEFAULT 0,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Capitulo = Challenge Step (part/step of a Desafio)
-- 1 Desafio has N Capitulo
CREATE TABLE IF NOT EXISTS Capitulo (
    id BIGSERIAL PRIMARY KEY,
    id_desafio BIGINT NOT NULL,
    intro_historia VARCHAR,
    xp_recompensa INT NOT NULL,
    contexto_historia VARCHAR,
    numero INT, -- to order chapters if needed
    FOREIGN KEY (id_desafio) REFERENCES Desafio(id) ON DELETE CASCADE
);

-- Objetivo = Objective (list of required tasks/goals for a chapter)
CREATE TABLE IF NOT EXISTS Objetivo (
    id BIGSERIAL PRIMARY KEY,
    id_capitulo BIGINT NOT NULL,
    descricao VARCHAR NOT NULL,
    ordem INT NOT NULL DEFAULT 0,
    FOREIGN KEY (id_capitulo) REFERENCES Capitulo(id) ON DELETE CASCADE
);

-- Dica = Hint for a particular chapter
CREATE TABLE IF NOT EXISTS Dica (
    id BIGSERIAL PRIMARY KEY,
    id_capitulo BIGINT NOT NULL,
    ordem INT NOT NULL,
    conteudo VARCHAR NOT NULL,
    penalidade_xp INT DEFAULT 0,
    FOREIGN KEY (id_capitulo) REFERENCES Capitulo(id) ON DELETE CASCADE
);

-- =============================================
-- DATABASE SCHEMA / VISÃO TABLES
-- =============================================

-- "Visao" describes a database context/schema for a Capitulo
CREATE TABLE IF NOT EXISTS Visao (
    id BIGSERIAL PRIMARY KEY,
    id_capitulo BIGINT NOT NULL,
    FOREIGN KEY (id_capitulo) REFERENCES Capitulo(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Visao_Tabela (
    id BIGSERIAL PRIMARY KEY,
    id_visao BIGINT NOT NULL,
    nome VARCHAR NOT NULL,
    descricao VARCHAR,
    FOREIGN KEY (id_visao) REFERENCES Visao(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Visao_Coluna (
    id BIGSERIAL PRIMARY KEY,
    id_tabela BIGINT NOT NULL,
    nome VARCHAR NOT NULL,
    tipo VARCHAR NOT NULL,
    nulavel BOOLEAN DEFAULT FALSE,
    chave_primaria BOOLEAN DEFAULT FALSE,
    fk_tabela VARCHAR,
    fk_coluna VARCHAR,
    descricao VARCHAR,
    FOREIGN KEY (id_tabela) REFERENCES Visao_Tabela(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Visao_Relacionamento (
    id BIGSERIAL PRIMARY KEY,
    id_visao BIGINT NOT NULL,
    tabela_origem VARCHAR NOT NULL,
    tabela_destino VARCHAR NOT NULL,
    tipo VARCHAR NOT NULL CHECK (tipo IN ('one-to-one', 'one-to-many', 'many-to-many')),
    coluna_origem VARCHAR NOT NULL,
    coluna_destino VARCHAR NOT NULL,
    FOREIGN KEY (id_visao) REFERENCES Visao(id) ON DELETE CASCADE
);

-- Sample/example data for each table (for the challenge DB context)
CREATE TABLE IF NOT EXISTS Visao_DadoExemplo (
    id BIGSERIAL PRIMARY KEY,
    id_tabela BIGINT NOT NULL,
    dados JSONB NOT NULL,
    FOREIGN KEY (id_tabela) REFERENCES Visao_Tabela(id) ON DELETE CASCADE
);

-- =============================================
-- CONSULTA / EXPECTED OUTPUT (Victory Flag)
-- =============================================

-- Stores columns and expected result for that chapter challenge
CREATE TABLE IF NOT EXISTS Consulta (
    id BIGSERIAL PRIMARY KEY,
    id_capitulo BIGINT NOT NULL,
    colunas VARCHAR[] NOT NULL,
    resultado JSONB NOT NULL, -- Expected table, array of objects!
    FOREIGN KEY (id_capitulo) REFERENCES Capitulo(id) ON DELETE CASCADE
);

-- =============================================
-- AUDIT LOG (Optional, for changes)
-- =============================================

CREATE TABLE IF NOT EXISTS Log (
    id SERIAL PRIMARY KEY,
    table_name VARCHAR(255) NOT NULL,
    operation VARCHAR(10) NOT NULL,
    old_data TEXT,
    new_data TEXT,
    changed_by VARCHAR(255) NOT NULL,
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Audit function (optional, supports Log table)
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

-- Triggers for core tables (optional, for Log)
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'desafio_audit') THEN
        CREATE TRIGGER desafio_audit AFTER INSERT OR UPDATE OR DELETE ON Desafio FOR EACH ROW EXECUTE FUNCTION log_changes();
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'capitulo_audit') THEN
        CREATE TRIGGER capitulo_audit AFTER INSERT OR UPDATE OR DELETE ON Capitulo FOR EACH ROW EXECUTE FUNCTION log_changes();
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'objetivo_audit') THEN
        CREATE TRIGGER objetivo_audit AFTER INSERT OR UPDATE OR DELETE ON Objetivo FOR EACH ROW EXECUTE FUNCTION log_changes();
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'dica_audit') THEN
        CREATE TRIGGER dica_audit AFTER INSERT OR UPDATE OR DELETE ON Dica FOR EACH ROW EXECUTE FUNCTION log_changes();
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'visao_audit') THEN
        CREATE TRIGGER visao_audit AFTER INSERT OR UPDATE OR DELETE ON Visao FOR EACH ROW EXECUTE FUNCTION log_changes();
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'visao_tabela_audit') THEN
        CREATE TRIGGER visao_tabela_audit AFTER INSERT OR UPDATE OR DELETE ON Visao_Tabela FOR EACH ROW EXECUTE FUNCTION log_changes();
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'visao_coluna_audit') THEN
        CREATE TRIGGER visao_coluna_audit AFTER INSERT OR UPDATE OR DELETE ON Visao_Coluna FOR EACH ROW EXECUTE FUNCTION log_changes();
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'consulta_audit') THEN
        CREATE TRIGGER consulta_audit AFTER INSERT OR UPDATE OR DELETE ON Consulta FOR EACH ROW EXECUTE FUNCTION log_changes();
    END IF;
END $$;