# sql-challenge-modelagem_de_dados

Modelagem de dados e conteúdo do jogo **SQL Challenge — Mistério do Mundo Mágico**.

## Estrutura

```
PostgreSQL/Script/
  gestão/
    ddl_structure.sql     → DDL das tabelas de gestão (Desafio, Capitulo, Objetivo,
                            Dica, Visao, Consulta, Log + triggers)
    dcl_security.sql      → Cria usuário de aplicação (users_sql_challenge)
  cadastro_games/
    dml_magical_world.sql → DML do conteúdo do jogo (1 desafio, 5 capítulos,
                            26 objetivos, 15 dicas, 23 visões, 26 consultas-solução)

Games/magical world/
  ddl_game.sql            → DDL das tabelas do mundo mágico (Feudo, Pessoa,
                            Artefato, Cidade, Ataques, Torres, etc.)
  dml_game.sql            → DML com dados do mundo mágico (8 feudos, pessoas,
                            artefatos, cidades, transações...)
  vw_ddl_game.sql         → Views do jogo (uma por objetivo, 23 views:
                            regioes_reinos, ataques_raw, grimorio_final...)
```

## Como semear o banco

### 1. Via script automatizado (recomendado)

O backend tem o script `scripts/db-init.sh` que orquestra tudo na ordem correta:

```bash
# A partir da raiz do repositório backend:
cd ../sql-challenge-backend

# Semeia apenas produção
bash scripts/db-init.sh --env production

# Semeia apenas staging/teste
bash scripts/db-init.sh --env staging

# Semeia ambos
bash scripts/db-init.sh --env all

# Reset total (apaga tudo e recria)
bash scripts/db-init.sh --env production --reset
```

O script usa este repositório automaticamente se estiver em `../sql-challenge-modelagem_de_dados`.

### 2. Via docker exec (manual)

Se o container já estiver rodando, execute os scripts na ordem abaixo:

```bash
# Ordem obrigatória:
# 1. Schema de gestão
docker exec -i sql-challenge-db psql -U challenge_user -d db_gestao \
  < /caminho/para/ddl_structure.sql

# 2. DDL do mundo mágico (requer SET search_path)
docker exec -i sql-challenge-db psql -U challenge_user -d db_gestao \
  -c "SET search_path TO magical_world;" \
  -f <(cat /caminho/para/ddl_game.sql)

# 3. Dados do mundo mágico (requer SET search_path)
docker exec -i sql-challenge-db psql -U challenge_user -d db_gestao \
  -c "SET search_path TO magical_world;" \
  -f <(cat /caminho/para/dml_game.sql)

# 4. Views do jogo (requer SET search_path)
docker exec -i sql-challenge-db psql -U challenge_user -d db_gestao \
  -c "SET search_path TO magical_world;" \
  -f <(cat /caminho/para/vw_ddl_game.sql)

# 5. Conteúdo do jogo (desafios, objetivos, consultas, dicas)
docker exec -i sql-challenge-db psql -U challenge_user -d db_gestao \
  < /caminho/para/dml_magical_world.sql

# 6. Usuário de aplicação (opcional, necessário para queries dos alunos)
docker exec -i sql-challenge-db psql -U challenge_user -d db_gestao \
  < /caminho/para/dcl_security.sql
```

> ⚠️ Os passos 2, 3 e 4 (arquivos `ddl_game.sql`, `dml_game.sql`, `vw_ddl_game.sql`) criam objetos no schema `magical_world`. Sem `SET search_path TO magical_world;` antes do `-f`, as tabelas e views serão criadas no schema `public` por padrão, e as consultas do jogo não encontrarão os dados.

## Atualização rápida (só conteúdo do jogo)

Quando apenas os objetivos, consultas ou dicas mudam (sem alterar tabelas ou views):

```bash
docker exec -i sql-challenge-db psql -U challenge_user -d db_gestao \
  < PostgreSQL/Script/cadastro_games/dml_magical_world.sql
```

## Verificação

```sql
-- Tabelas de gestão
SELECT 'Desafio',  COUNT(*) FROM Desafio
UNION ALL SELECT 'Capitulo', COUNT(*) FROM Capitulo
UNION ALL SELECT 'Objetivo', COUNT(*) FROM Objetivo
UNION ALL SELECT 'Dica',     COUNT(*) FROM Dica
UNION ALL SELECT 'Visao',    COUNT(*) FROM Visao
UNION ALL SELECT 'Consulta', COUNT(*) FROM Consulta;

-- Tabelas do mundo mágico
SELECT 'Feudo',  COUNT(*) FROM magical_world.Feudo
UNION ALL SELECT 'Pessoa', COUNT(*) FROM magical_world.Pessoa;
```

Esperado: 1 Desafio, 5 Capítulos, 26 Objetivos, 15 Dicas, 23 Visões, 26 Consultas.
