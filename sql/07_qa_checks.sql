-- ============================================================
-- QA - Integridade e solubilidade do conteúdo do jogo
-- Somente leitura: NÃO altera dados. Seguro para rodar em produção.
-- Execute APÓS 05_challenge_content.sql (e 04_game_views.sql).
--
-- Cobre a classe de bugs que deixou objetivos impossíveis em produção:
--   - Visao.comando apontando para view inexistente
--   - view vazia (o cliente não cria a tabela no SQLite do jogo)
--   - objetivo sem consulta-solução
--   - consulta-solução que não executa ou não devolve as colunas esperadas
--   - consulta-solução que retorna 0 linhas
--   - ataques_raw × ataques_detalhe divergentes
--   - objetivo/consulta em capítulos diferentes, ordem duplicada, dicas faltando
--
-- Falhas aparecem como WARNING no stderr do psql (não abortam o pipeline).
-- ============================================================

SET search_path TO public, magical_world;
SET client_min_messages TO warning;

-- 1. Toda view referenciada em Visao existe.
DO $$
DECLARE
    r RECORD;
BEGIN
    FOR r IN SELECT id, comando FROM visao LOOP
        IF NOT EXISTS (
            SELECT 1 FROM pg_views
            WHERE schemaname = split_part(r.comando, '.', 1)
              AND viewname   = split_part(r.comando, '.', 2)
        ) THEN
            RAISE WARNING 'QA: visao % aponta para view inexistente: %', r.id, r.comando;
        END IF;
    END LOOP;
END $$;

-- 2. Toda view usada no jogo retorna ao menos 1 linha.
--    View vazia => o cliente descarta a tabela (colunas derivadas do 1º row).
DO $$
DECLARE
    r RECORD;
    total BIGINT;
BEGIN
    FOR r IN SELECT DISTINCT comando FROM visao LOOP
        BEGIN
            EXECUTE format('SELECT count(*) FROM %s', r.comando) INTO total;
            IF total = 0 THEN
                RAISE WARNING 'QA: view % está vazia (nenhuma linha)', r.comando;
            END IF;
        EXCEPTION WHEN OTHERS THEN
            RAISE WARNING 'QA: falha ao consultar %: %', r.comando, SQLERRM;
        END;
    END LOOP;
END $$;

-- 3. Todo objetivo possui consulta-solução.
DO $$
DECLARE
    r RECORD;
BEGIN
    FOR r IN
        SELECT o.id, o.id_capitulo, o.ordem
        FROM objetivo o
        LEFT JOIN consulta c ON c.id_objetivo = o.id
        WHERE c.id IS NULL
    LOOP
        RAISE WARNING 'QA: objetivo % (capitulo %, ordem %) não possui consulta',
            r.id, r.id_capitulo, r.ordem;
    END LOOP;
END $$;

-- 4. Toda consulta-solução executa, devolve as colunas esperadas e >= 1 linha.
DO $$
DECLARE
    r RECORD;
    missing TEXT[];
BEGIN
    FOR r IN SELECT id, id_objetivo, query, colunas FROM consulta ORDER BY id LOOP
        BEGIN
            DROP TABLE IF EXISTS _qa_result;
            EXECUTE 'CREATE TEMP TABLE _qa_result AS ' || r.query;

            SELECT array_agg(expected.col) INTO missing
            FROM unnest(r.colunas) AS expected(col)
            WHERE NOT EXISTS (
                SELECT 1
                FROM information_schema.columns c
                WHERE c.table_name = '_qa_result'
                  AND c.table_schema LIKE 'pg_temp%'
                  AND lower(c.column_name) = lower(expected.col)
            );

            IF missing IS NOT NULL THEN
                RAISE WARNING 'QA: consulta % (objetivo %) não retorna as colunas esperadas: %',
                    r.id, r.id_objetivo, missing;
            END IF;

            IF (SELECT count(*) FROM _qa_result) = 0 THEN
                RAISE WARNING 'QA: consulta % (objetivo %) retorna 0 linhas',
                    r.id, r.id_objetivo;
            END IF;

            DROP TABLE IF EXISTS _qa_result;
        EXCEPTION WHEN OTHERS THEN
            RAISE WARNING 'QA: consulta % (objetivo %) falhou: %',
                r.id, r.id_objetivo, SQLERRM;
            DROP TABLE IF EXISTS _qa_result;
        END;
    END LOOP;
END $$;

-- 5. ataques_raw × ataques_detalhe devem cobrir os mesmos ataques.
DO $$
DECLARE
    raw_justiceiros BIGINT;
    detalhe_total   BIGINT;
BEGIN
    SELECT count(*) INTO raw_justiceiros FROM ataques_raw WHERE autor = 'Os Justiceiros';
    SELECT count(*) INTO detalhe_total   FROM ataques_detalhe;

    IF raw_justiceiros <> detalhe_total THEN
        RAISE WARNING 'QA: ataques_raw (Justiceiros=%) e ataques_detalhe (%) divergem',
            raw_justiceiros, detalhe_total;
    END IF;
END $$;

-- 6. Consulta e objetivo devem pertencer ao mesmo capítulo.
DO $$
DECLARE
    r RECORD;
BEGIN
    FOR r IN
        SELECT c.id, c.id_capitulo AS consulta_cap, o.id_capitulo AS objetivo_cap
        FROM consulta c
        JOIN objetivo o ON o.id = c.id_objetivo
        WHERE c.id_capitulo <> o.id_capitulo
    LOOP
        RAISE WARNING 'QA: consulta % no capitulo % mas objetivo pertence ao capitulo %',
            r.id, r.consulta_cap, r.objetivo_cap;
    END LOOP;
END $$;

-- 7. Ordem de objetivos duplicada dentro do mesmo capítulo.
DO $$
DECLARE
    r RECORD;
BEGIN
    FOR r IN
        SELECT id_capitulo, ordem, count(*) AS total
        FROM objetivo
        GROUP BY id_capitulo, ordem
        HAVING count(*) > 1
    LOOP
        RAISE WARNING 'QA: capitulo % tem % objetivos na ordem %',
            r.id_capitulo, r.total, r.ordem;
    END LOOP;
END $$;

-- 8. Cada capítulo deve ter exatamente 3 dicas.
DO $$
DECLARE
    r RECORD;
BEGIN
    FOR r IN
        SELECT id_capitulo, count(*) AS total
        FROM dica
        GROUP BY id_capitulo
        HAVING count(*) <> 3
    LOOP
        RAISE WARNING 'QA: capitulo % tem % dicas (esperado: 3)',
            r.id_capitulo, r.total;
    END LOOP;
END $$;

-- 9. Resumo informativo.
SELECT 'capitulos' AS entidade, count(*) AS total FROM capitulo
UNION ALL SELECT 'objetivos', count(*) FROM objetivo
UNION ALL SELECT 'consultas',  count(*) FROM consulta
UNION ALL SELECT 'dicas',      count(*) FROM dica
UNION ALL SELECT 'views',      count(*) FROM visao
ORDER BY entidade;
