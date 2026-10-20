# sql-challenge-modelagem_de_dados

Modelagem de dados e conteúdo do **SQL Challenge — Mistério do Mundo Mágico**.

Este repositório é a **fonte de verdade do banco de dados**: schema de gestão, mundo mágico, views, conteúdo do jogo e o usuário de aplicação. Backend, frontend e k8s consomem estes arquivos — o contrato completo está em [DATABASE.md](./DATABASE.md).

## Estrutura

```
sql/
  01_gestao_ddl.sql          → DDL das tabelas de gestão (Desafio, Capitulo, Objetivo,
                               Dica, Visao, Consulta, Log + triggers)
  02_magical_world_ddl.sql   → DDL do mundo mágico (Feudo, Pessoa, Artefato, Cidade, ...)
  03_magical_world_dml.sql   → Dados do mundo mágico (8 feudos, pessoas, artefatos...)
  04_game_views.sql          → Views do jogo (uma por objetivo, 23 views)
  05_challenge_content.sql   → Conteúdo do jogo (1 desafio, 5 capítulos, 26 objetivos,
                               15 dicas, 23 visões, 26 consultas-solução)
  06_security_dcl.sql        → Usuário de aplicação somente-leitura (parametrizado)
  07_qa_checks.sql           → Verificações de integridade e solubilidade (somente leitura)

uml/
  UML.png                    → Diagrama relacional (drawSQL)
  UML_LINK.txt               → Link do diagrama no drawSQL
  FIREBASE_UML.puml/.png     → Modelagem lógica do Firestore (PlantUML)
```

## Como aplicar

A ordem é a numeração: `01` → `07`. Todos os arquivos são idempotentes e podem ser reexecutados com segurança
(`07` é somente leitura).

### Desenvolvimento local (recomendado)

O banco de dev é gerenciado pelo repositório backend:

```bash
cd ../sql-challenge-backend

bash scripts/db-dev.sh up       # sobe o db_gestao_dev (porta 5432) e aplica o pipeline
bash scripts/db-dev.sh reseed   # recria o banco do zero
bash scripts/db-dev.sh psql     # abre o psql no banco de dev
```

### Manual (psql)

```bash
DB=db_gestao_dev

# Pipeline 01 → 05
for f in sql/0[1-5]_*.sql; do
  psql -v ON_ERROR_STOP=1 -d "$DB" -f "$f"
done

# Verificações de integridade/solubilidade (somente leitura; warnings no stderr)
psql -d "$DB" -f sql/07_qa_checks.sql

# DCL (usuário de aplicação)
psql -d "$DB" \
  -v app_user=users_sql_challenge \
  -v app_password="$APP_PASSWORD" \
  -v app_db="$DB" \
  -f sql/06_security_dcl.sql
```

> ⚠️ `03` e `04` usam `SET search_path TO magical_world` — o schema é criado no `02`.

### Staging / Produção

No servidor, a semeadura é orquestrada pelo backend:

```bash
cd ../sql-challenge-backend
bash scripts/db-init.sh --env production   # ou --env staging
```

Em produção a semeadura é **não destrutiva** (`CREATE ... IF NOT EXISTS`). Para recriar do zero use `--reset` (apaga o volume — confirmação obrigatória).

## Verificação

```sql
SELECT 'Desafio'  AS tabela, COUNT(*) FROM Desafio
UNION ALL SELECT 'Capitulo',  COUNT(*) FROM Capitulo
UNION ALL SELECT 'Objetivo',  COUNT(*) FROM Objetivo
UNION ALL SELECT 'Dica',      COUNT(*) FROM Dica
UNION ALL SELECT 'Visao',     COUNT(*) FROM Visao
UNION ALL SELECT 'Consulta',  COUNT(*) FROM Consulta
UNION ALL SELECT 'magical_world.Feudo',    COUNT(*) FROM magical_world.Feudo
UNION ALL SELECT 'magical_world.Pessoa',   COUNT(*) FROM magical_world.Pessoa
UNION ALL SELECT 'magical_world.Artefato', COUNT(*) FROM magical_world.Artefato;
```

Esperado: **1 Desafio · 5 Capítulos · 26 Objetivos · 15 Dicas · 23 Visões · 26 Consultas** · 8 Feudos.

## Documentação

| Arquivo | Conteúdo |
|---------|----------|
| [DATABASE.md](./DATABASE.md) | Contrato do pipeline: ordem, ambientes, DCL, convenções para repositórios dependentes |
| [REVIEW.md](./REVIEW.md) | Auditoria de bootstrap/segurança (2026-10) e decisões tomadas |

## Licença

MIT — veja [LICENSE](./LICENSE).
