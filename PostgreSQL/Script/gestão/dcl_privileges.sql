-- Concede permissão de SELECT para todas as tabelas no esquema 'public'
GRANT SELECT ON ALL TABLES IN SCHEMA public TO user_gestao_challenge;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO user_gestao_challenge;