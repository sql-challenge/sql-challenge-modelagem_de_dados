-- ============================================================
-- DCL — Usuário de aplicação (somente leitura)
-- ============================================================
-- Cria/atualiza o usuário usado para disponibilizar as bases aos
-- jogadores (ex.: users_sql_challenge) e concede acesso de leitura
-- aos schemas public (gestão) e magical_world (jogo).
--
-- Parâmetros (psql -v):
--   app_user      usuário de aplicação   (ex.: users_sql_challenge)
--   app_password  senha do usuário       (obrigatório)
--   app_db        banco de dados alvo    (ex.: db_gestao, db_gestao_dev)
--
-- Uso:
--   psql -v app_user=users_sql_challenge \
--        -v app_password="$APP_PASSWORD" \
--        -v app_db=db_gestao \
--        -f sql/06_security_dcl.sql
--
-- Idempotente: pode ser executado quantas vezes for necessário.
-- ============================================================

\set ON_ERROR_STOP on

-- 1. Cria o usuário se ainda não existir
SELECT format('CREATE USER %I WITH PASSWORD %L', :'app_user', :'app_password')
WHERE NOT EXISTS (SELECT FROM pg_roles WHERE rolname = :'app_user')
\gexec

-- 2. Mantém a senha sincronizada com o parâmetro recebido
SELECT format('ALTER USER %I WITH PASSWORD %L', :'app_user', :'app_password')
\gexec

-- 3. Permite conexão ao banco
SELECT format('GRANT CONNECT ON DATABASE %I TO %I', :'app_db', :'app_user')
\gexec

-- 4. Fuso horário da base
SELECT format('ALTER DATABASE %I SET timezone TO %L', :'app_db', 'America/Sao_Paulo')
\gexec

-- 5. Leitura nos schemas existentes (public e magical_world)
SELECT format('GRANT USAGE ON SCHEMA %I TO %I', nspname, :'app_user')
FROM pg_namespace
WHERE nspname IN ('public', 'magical_world')
\gexec

SELECT format('GRANT SELECT ON ALL TABLES IN SCHEMA %I TO %I', nspname, :'app_user')
FROM pg_namespace
WHERE nspname IN ('public', 'magical_world')
\gexec

SELECT format('ALTER DEFAULT PRIVILEGES IN SCHEMA %I GRANT SELECT ON TABLES TO %I', nspname, :'app_user')
FROM pg_namespace
WHERE nspname IN ('public', 'magical_world')
\gexec
