# REVIEW.md — Auditoria de bootstrap e segurança (2026-10)

Revisão profunda do pipeline de banco e dos fluxos de inicialização nos repositórios dependentes. Cada item traz severidade, evidência e status.

## 🔴 Críticos

### R1 — Dev usava o banco "produção" local ✅ resolvido
O `.env` do backend (carregado pelo `npm run dev`) apontava `DATABASE_URL` para `db_gestao` na porta 5432 — o mesmo desenho do servidor de produção (container `sql-challenge-db`, volume `pgdata`). Não existia ambiente de dev.
**Correção**: banco de dev dedicado (`db_gestao_dev`, container `sql-challenge-db-dev`, `docker-compose.dev.yml`) gerenciado por `scripts/db-dev.sh`. O ambiente local agora é exclusivamente dev.

### R2 — Semeadura de produção destruía dados ✅ resolvido
`db-init.sh --env production` aplicava `tests/fixtures/schema.sql`, que começa com `DROP TABLE IF EXISTS ... CASCADE` em todas as tabelas de gestão — um "seed" apagava tudo silenciosamente.
**Correção**: produção agora aplica `sql/01_gestao_ddl.sql` (aditivo, `CREATE IF NOT EXISTS`). Destruição só via `--reset` (wipe de volume, com confirmação).

### R3 — Chave privada Firebase Admin commitada ✅ resolvido (rotação pendente)
Chave real presente em arquivos rastreados: `sql-challenge-backend/setup-env.sh` e `sql-challenge-frontend/scripts/vps-setup.sh` (2 ocorrências). Já publicada no GitHub.
**Correção**: segredos removidos dos arquivos rastreados (scripts passam a ler variáveis de ambiente); rostação da chave é ação manual no console do Firebase/GCP. Purge de histórico (git filter-repo) adiado por decisão.

### R4 — `--env all` (padrão) quebrava sem `.env.staging` ✅ resolvido
O padrão do `db-init.sh` exigia `.env.staging` (inexistente no repositório). O README das duas pontas anunciava `--env all` como caminho normal.
**Correção**: o padrão agora é `dev` (local); ambientes de servidor exigem `--env production|staging|all` explícito.

## 🟠 Importantes

### R5 — Duas fontes de verdade para o schema de gestão ✅ resolvido
`ddl_structure.sql` (modelagem) nunca era executado; o bootstrap usava a cópia derivada `tests/fixtures/schema.sql` — risco de drift silencioso.
**Correção**: o pipeline numerado de `sql/` é a fonte executada; fixtures ficam como snapshots de CI, documentadas como tal.

### R6 — DCL frágil (sed + senha fixa) ✅ resolvido
`dcl_security.sql` usava nomes antigos (`user_gestao_challenge`, `db_gestao_challenge`) e senha fixa `senha123`; o backend reescrevia o arquivo com `sed` de literais em português.
**Correção**: `sql/06_security_dcl.sql` parametrizado via `psql -v` (`app_user`, `app_password`, `app_db`), idempotente, com os grants incorporados.

### R7 — Staging com bootstrap parcial 🟡 documentado
`docker-compose.staging.yml` auto-inicializa apenas schema + dump do mundo mágico (sem conteúdo do jogo e sem usuário de aplicação) via `docker-entrypoint-initdb.d`. O fluxo completo depende de `db-init.sh --env staging`.
**Status**: documentado; possíveis melhorias registradas para quando o staging passar a usar o pipeline numerado no servidor.

## 🟡 Menores

### R8 — Caminhos com acento/espaço ✅ resolvido
`PostgreSQL/Script/gestão/`, `Games/magical world/`, `link da construção uml.txt` exigiam quoting e podiam quebrar por normalização Unicode (macOS NFD vs Linux NFC).
**Correção**: caminhos ASCII (`sql/`, `uml/`).

### R9 — `db-init.sh`: bugs menores ✅ resolvido
Rótulos inconsistentes (`[1/7]` vs `[3/6]`), listas de arquivos hardcoded, cancelamento do `--reset` abortando o script sob `set -e`.
**Correção**: pipeline dirigido por diretório (`sql/`), rótulos padronizados `/6`, cancelamento limpo com mensagem.

### R10 — README raiz instruía semear produção na máquina local ✅ resolvido
O quick start do monorepo mandava rodar `db-init.sh --env production` localmente.
**Correção**: quick start usa o fluxo de dev (`db-dev.sh`); matriz de ambientes documentada.

## Convenções resultantes

Ver [DATABASE.md](./DATABASE.md) §5 — numeração como ordem, bootstrap aditivo, ASCII, fixtures como snapshots de CI.
