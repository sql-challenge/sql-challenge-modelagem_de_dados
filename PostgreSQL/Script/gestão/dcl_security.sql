-- Drop do usuário se existir (com CASCADE para remover objetos criados por ele)
DROP USER IF EXISTS users_sql_challenge CASCADE;

-- Criação do usuário para a aplicação
CREATE USER users_sql_challenge WITH PASSWORD 'senha123';

-- Concede permissão de conexão ao novo usuário no banco de dados
GRANT CONNECT ON DATABASE db_gestao TO users_sql_challenge;

-- Concede permissões de uso ao schema public
GRANT USAGE ON SCHEMA public TO users_sql_challenge;
GRANT CREATE ON SCHEMA public TO users_sql_challenge;

-- Define o fuso horário para a base de dados
ALTER DATABASE db_gestao SET timezone TO 'America/Sao_Paulo';