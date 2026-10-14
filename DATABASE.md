# DATABASE.md — Pipeline de banco e contrato

Documento de referência do **`sql-challenge-modelagem_de_dados`** para todos os repositórios que dependem dele (backend, frontend, k8s).

## 1. Pipeline (ordem obrigatória)

Os arquivos em `sql/` são executados em **ordem lexical** — a numeração é o contrato:

| # | Arquivo | Cria | Depende de |
|---|---------|------|------------|
| 01 | `01_gestao_ddl.sql` | Tabelas de gestão (Desafio, Capitulo, Objetivo, Dica, Visao, Consulta, Log) + triggers de auditoria | — |
| 02 | `02_magical_world_ddl.sql` | Schema `magical_world` + tabelas do jogo (Feudo, Pessoa, Artefato, Cidade, Ataques, Torres...) | — |
| 03 | `03_magical_world_dml.sql` | Dados do mundo mágico | 02 |
| 04 | `04_game_views.sql` | Views do jogo (uma por objetivo; 23 views) | 02, 03 |
| 05 | `05_challenge_content.sql` | Conteúdo do jogo: desafio, capítulos, objetivos, dicas, visões, consultas-solução | 01, 04 |
| 06 | `06_security_dcl.sql` | Usuário de aplicação somente-leitura + grants (parametrizado) | 01, 02 |

Propriedades:

- **`01` e `02` são aditivos** (`CREATE ... IF NOT EXISTS`) — nunca destroem dados em bootstrap normal.
- **`05` limpa as tabelas de conteúdo antes de reinserir** — recarga segura e repetível.
- **`06` é idempotente** e recebe parâmetros via `psql -v` (ver seção 4).
- O bootstrap **não** usa `DROP TABLE`/`DROP DATABASE`. Ponto de partida limpo = volume novo (dev/staging) ou `--reset` (servidor).

## 2. Ambientes

| Ambiente | Banco | Porta (host) | Onde roda | Quem aplica o pipeline |
|----------|-------|--------------|-----------|------------------------|
| **dev** | `db_gestao_dev` | 5432 | máquina do desenvolvedor | `backend/scripts/db-dev.sh` |
| **staging** | `db_gestao_staging` | 5433 | servidor | `backend/scripts/db-init.sh --env staging` |
| **produção** | `db_gestao` | 5432 | servidor | `backend/scripts/db-init.sh --env production` |

Regras de isolamento:

- O banco de dev é o **único** banco na máquina do desenvolvedor — o pipeline nunca aponta para staging/produção.
- Os nomes de container são distintos: `sql-challenge-db-dev` (dev), `sql-challenge-db-staging` (staging), `sql-challenge-db` (produção).
- O deploy de staging/produção é feito pelo GitHub Actions (`.github/workflows/cd.yml`), que escreve o `.env` a partir de secrets.

### 2.1 Dev (local)

```bash
cd ../sql-challenge-backend

bash scripts/db-dev.sh up       # sobe + semeia (se vazio)
bash scripts/db-dev.sh reseed   # recria do zero (down -v + seed)
bash scripts/db-dev.sh psql     # sessão psql no db_gestao_dev
bash scripts/db-dev.sh status   # container + versão
```

Detalhes de setup do ambiente: `backend/DEVELOPMENT.md`.

### 2.2 Staging / produção (servidor)

```bash
cd /opt/apps/sql-challenge/backend   # servidor

bash scripts/db-init.sh --env production   # semeadura não destrutiva
bash scripts/db-init.sh --env staging
bash scripts/db-init.sh --env production --reset   # ⚠️ apaga o volume (prompt de confirmação)
```

O servidor precisa do repositório modelagem clonado ao lado do backend (`--modelagem DIR` para customizar).

## 3. Verificação

Após qualquer semeadura, a contagem esperada é:

| Tabela | Linhas |
|--------|--------|
| `Desafio` | 1 |
| `Capitulo` | 5 |
| `Objetivo` | 26 |
| `Dica` | 15 |
| `Visao` | 23 |
| `Consulta` | 26 |
| `magical_world.Feudo` | 8 |

O `db-dev.sh up`/`reseed` e o `db-init.sh` imprimem essa verificação automaticamente. Regra de CI/k8s: `COUNT(*)` por tabela.

## 4. DCL — usuário de aplicação

`06_security_dcl.sql` é parametrizado:

| Parâmetro | Descrição | Exemplo |
|-----------|-----------|---------|
| `app_user` | Nome do usuário de aplicação | `users_sql_challenge` |
| `app_password` | Senha do usuário | senha do ambiente |
| `app_db` | Banco alvo | `db_gestao_dev`, `db_gestao` |

```bash
psql -v ON_ERROR_STOP=1 -d "$DB" \
  -v app_user=users_sql_challenge \
  -v app_password="$APP_PASSWORD" \
  -v app_db="$DB" \
  -f sql/06_security_dcl.sql
```

O script:

1. cria o usuário se não existir;
2. sincroniza a senha (`ALTER USER`);
3. concede `CONNECT` no banco;
4. define timezone `America/Sao_Paulo`;
5. concede `USAGE` + `SELECT` nos schemas `public` e `magical_world` (somente se existirem) + default privileges.

## 5. Convenções (contrato para repositórios dependentes)

1. **Numeração = ordem.** Qualquer arquivo novo segue `NN_nome.sql` e roda em ordem lexical.
2. **Bootstrap é aditivo.** Nunca inclua `DROP` em bootstrap normal; recriação é responsabilidade do volume/reset.
3. **Mudança de conteúdo** (`05`): edite o arquivo; ele recarrega as tabelas de conteúdo.
4. **Mudança de schema**: novo arquivo numerado (`07_...`), aditivo (`CREATE IF NOT EXISTS` / `ALTER`). Mudanças destrutivas exigem migração coordenada com o deploy da aplicação.
5. **Caminhos são ASCII** (sem acentos/espaços) e relativos à raiz do repositório.
6. **Externos**:
   - `backend/scripts/db-init.sh` (staging/produção) e `backend/scripts/db-dev.sh` (dev) executam o pipeline.
   - `backend/tests/fixtures/*.sql` são **snapshots para CI** — atualizar quando `01`/`05` mudarem de forma relevante.
   - `k8s/` (repo raiz) copia os arquivos `sql/` para o pod do Postgres.

## 6. Histórico

A auditoria que originou esta organização (drift fixture/schema, DCL frágil, caminhos com acento, bootstrap destrutivo) está em [REVIEW.md](./REVIEW.md).
