-- ============================================================
-- DDL - db_gestao
-- Banco de gestão do SQL-Challenger
-- Alinhado com entidades TypeScript do back-end
-- Data: 2026-04-04
-- ============================================================

DROP DATABASE IF EXISTS db_gestao;
CREATE DATABASE db_gestao;

-- Conecte-se antes de continuar:
-- psql -U admin -d db_gestao -h localhost -p 5432

-- ============================================================
-- SCHEMAS
-- ============================================================
CREATE SCHEMA IF NOT EXISTS magical_world; -- banco do jogo
-- As tabelas de gestão ficam no schema public (padrão)

-- ============================================================
-- DROP das tabelas (ordem respeitando dependências de FK)
-- ============================================================
DROP TABLE IF EXISTS Log          CASCADE;
DROP TABLE IF EXISTS Dica         CASCADE;
DROP TABLE IF EXISTS Consulta     CASCADE;
DROP TABLE IF EXISTS Objetivo     CASCADE;
DROP TABLE IF EXISTS Visao        CASCADE;
DROP TABLE IF EXISTS Capitulo     CASCADE;
DROP TABLE IF EXISTS Desafio      CASCADE;
DROP FUNCTION IF EXISTS log_changes() CASCADE;

-- ============================================================
-- TABELA: Desafio
-- Representa o jogo/aventura completa (ex.: "Mistério do Mundo Mágico").
-- Um Desafio contém vários Capítulos.
-- ============================================================
CREATE TABLE IF NOT EXISTS Desafio (
    id             BIGSERIAL    PRIMARY KEY,
    titulo         VARCHAR(255) NOT NULL,
    descricao      TEXT,
    tempo_estimado VARCHAR(50),
    taxa_conclusao NUMERIC(5,2) DEFAULT 0,
    criado_em      TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    atualizado_em  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- TABELA: Capitulo
-- Cada capítulo pertence a um Desafio.
-- Possui narrativa (intro + contexto), recompensa de XP e número de ordem.
-- ============================================================
CREATE TABLE IF NOT EXISTS Capitulo (
    id                BIGSERIAL PRIMARY KEY,
    id_desafio        BIGINT    NOT NULL REFERENCES Desafio(id) ON DELETE CASCADE,
    numero            INT       NOT NULL,
    intro_historia    TEXT,
    contexto_historia TEXT,
    xp_recompensa     INT       NOT NULL DEFAULT 0
);

-- ============================================================
-- TABELA: Objetivo
-- Cada objetivo pertence a um Capítulo e representa uma tarefa SQL
-- que o jogador deve concluir, exibida em ordem crescente.
-- ============================================================
CREATE TABLE IF NOT EXISTS Objetivo (
    id          BIGSERIAL PRIMARY KEY,
    id_capitulo BIGINT    NOT NULL REFERENCES Capitulo(id) ON DELETE CASCADE,
    descricao   TEXT      NOT NULL,
    ordem       INT       NOT NULL,
    nivel       INT       NOT NULL DEFAULT 0
);

-- ============================================================
-- TABELA: Dica
-- Dicas que o jogador pode revelar para ajudá-lo em cada capítulo.
-- Cada dica revelada desconta penalidade_xp do XP final.
-- ============================================================
CREATE TABLE IF NOT EXISTS Dica (
    id            BIGSERIAL    PRIMARY KEY,
    id_capitulo   BIGINT       NOT NULL REFERENCES Capitulo(id) ON DELETE CASCADE,
    ordem         INT          NOT NULL,
    conteudo      TEXT         NOT NULL,
    penalidade_xp INT          NOT NULL DEFAULT 0
);

-- ============================================================
-- TABELA: Visao
-- Representa uma VIEW do banco de dados do jogo (ex.: "regioes_reinos")
-- que o jogador pode consultar naquele capítulo.
-- O campo 'comando' guarda o nome da VIEW no banco do jogo.
-- ============================================================
CREATE TABLE IF NOT EXISTS Visao (
    id          BIGSERIAL    PRIMARY KEY,
    id_capitulo BIGINT       NOT NULL REFERENCES Capitulo(id) ON DELETE CASCADE,
    comando     VARCHAR(255) NOT NULL  -- nome qualificado: magical_world.nome_view
);

-- ============================================================
-- TABELA: Consulta
-- A consulta-solução esperada para cada objetivo do capítulo.
-- 'query'      → SQL correto que resolve o objetivo.
-- 'colunas'    → Array JSON com os nomes das colunas do resultado esperado.
-- 'resultado'  → Array JSON com as linhas de dados esperadas (opcional).
-- 'id_objetivo'→ Vínculo com o objetivo específico que esta consulta valida.
-- ============================================================
CREATE TABLE IF NOT EXISTS Consulta (
    id           BIGSERIAL PRIMARY KEY,
    id_capitulo  BIGINT    NOT NULL REFERENCES Capitulo(id) ON DELETE CASCADE,
    id_objetivo  BIGINT    REFERENCES Objetivo(id) ON DELETE CASCADE,
    query        TEXT      NOT NULL,
    colunas      JSONB,
    resultado    JSONB
);

-- ============================================================
-- TABELA: Log
-- Auditoria automática de todas as operações DML nas tabelas principais.
-- 'old_data' e 'new_data' são JSONB para compatibilidade com a entidade TS.
-- ============================================================
CREATE TABLE IF NOT EXISTS Log (
    id         SERIAL       PRIMARY KEY,
    table_name VARCHAR(255) NOT NULL,
    operation  VARCHAR(10)  NOT NULL,
    old_data   JSONB,
    new_data   JSONB,
    changed_by VARCHAR(255) NOT NULL,
    changed_at TIMESTAMP    DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- ============================================================
-- FUNÇÃO DE AUDITORIA
-- Registra INSERT, UPDATE e DELETE em JSONB (não TEXT).
-- ============================================================
CREATE OR REPLACE FUNCTION log_changes()
RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'DELETE') THEN
        INSERT INTO Log (table_name, operation, old_data, changed_by)
        VALUES (TG_TABLE_NAME, 'DELETE', to_jsonb(OLD), current_user);
        RETURN OLD;
    ELSIF (TG_OP = 'UPDATE') THEN
        INSERT INTO Log (table_name, operation, old_data, new_data, changed_by)
        VALUES (TG_TABLE_NAME, 'UPDATE', to_jsonb(OLD), to_jsonb(NEW), current_user);
        RETURN NEW;
    ELSIF (TG_OP = 'INSERT') THEN
        INSERT INTO Log (table_name, operation, new_data, changed_by)
        VALUES (TG_TABLE_NAME, 'INSERT', to_jsonb(NEW), current_user);
        RETURN NEW;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- ============================================================
-- TRIGGERS DE AUDITORIA (idempotentes — seguros para re-execução)
-- ============================================================
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'desafio_audit') THEN
        CREATE TRIGGER desafio_audit
            AFTER INSERT OR UPDATE OR DELETE ON Desafio
            FOR EACH ROW EXECUTE FUNCTION log_changes();
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'capitulo_audit') THEN
        CREATE TRIGGER capitulo_audit
            AFTER INSERT OR UPDATE OR DELETE ON Capitulo
            FOR EACH ROW EXECUTE FUNCTION log_changes();
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'objetivo_audit') THEN
        CREATE TRIGGER objetivo_audit
            AFTER INSERT OR UPDATE OR DELETE ON Objetivo
            FOR EACH ROW EXECUTE FUNCTION log_changes();
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'dica_audit') THEN
        CREATE TRIGGER dica_audit
            AFTER INSERT OR UPDATE OR DELETE ON Dica
            FOR EACH ROW EXECUTE FUNCTION log_changes();
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'visao_audit') THEN
        CREATE TRIGGER visao_audit
            AFTER INSERT OR UPDATE OR DELETE ON Visao
            FOR EACH ROW EXECUTE FUNCTION log_changes();
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'consulta_audit') THEN
        CREATE TRIGGER consulta_audit
            AFTER INSERT OR UPDATE OR DELETE ON Consulta
            FOR EACH ROW EXECUTE FUNCTION log_changes();
    END IF;
END $$;

-- ============================================================
-- PERMISSÕES
-- ============================================================
GRANT SELECT ON ALL TABLES IN SCHEMA public TO user_gestao_challenge;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO user_gestao_challenge;
