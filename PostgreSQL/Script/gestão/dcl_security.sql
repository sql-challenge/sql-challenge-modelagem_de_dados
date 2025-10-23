-- Criação do usuário para a aplicação
CREATE USER user_gestao_challenge WITH PASSWORD 'senha123';

-- Concede permissão de conexão ao novo usuário no banco de dados
GRANT CONNECT ON DATABASE db_gestao_challenge TO user_gestao_challenge;

-- Define o fuso horário para a base de dados
ALTER DATABASE db_gestao_challenge SET timezone TO 'America/Sao_Paulo';