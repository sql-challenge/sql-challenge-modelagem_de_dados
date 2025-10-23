-- =====================================================================
-- CAPÍTULO 1: MAPEANDO O MUNDO MÁGICO [NÍVEL MÁXIMO: 1]
-- =====================================================================

-- Objetivo 1: Identificar todas as regiões e reinos do mundo mágico listados no banco de dados. (Level 0)
SELECT nome_reino, geografia FROM regioes_reinos;

-- Objetivo 2: Listar as espécies que governam cada território. (Level 0)
SELECT especie_governante FROM especies_governantes;

-- Objetivo 3: Encontrar o nome dos Senhores das Terras de cada território. (Level 0)
SELECT nome_senhor, sobrenome_senhor, territorio_governado FROM senhores_das_terras;

-- Objetivo 4: Verificar quais territórios possuem ligação com artefatos lendários. (Level 1)
SELECT nome_artefato, territorio_localizacao
FROM artefatos_por_territorio
WHERE categoria = 'L';

-- Objetivo 5: Explorar as visões das tabelas de regiões para entender relações iniciais e interdependências. (Level 0)
SELECT * FROM regioes_reinos;
SELECT * FROM senhores_das_terras;

-- Objetivo 6: Identificar o rei mais antigo ainda vivo, com a idade dele. (Level 1)
SELECT nome, sobreNome, EXTRACT(YEAR FROM AGE(CURRENT_DATE, nascimento)) AS idade_atual
FROM pessoas_vivas
WHERE óbito IS NULL
ORDER BY nascimento ASC
LIMIT 1;

-- =====================================================================
-- CAPÍTULO 2: PRIMEIRAS PISTAS DOS JUSTICEIROS [NÍVEL MÁXIMO: 2]
-- =====================================================================

-- Objetivo 1: Localizar todos os registros de ataques atribuídos aos Justiceiros. (Level 1)
SELECT data_ocorrido, id_territorio
FROM ataques_raw
WHERE autor = 'Os Justiceiros';

-- Objetivo 2: Agrupar os ataques por território e contar a quantidade de ocorrências. (Level 2)
SELECT territorio_atacado, COUNT(id) AS total_ataques
FROM ataques_detalhe
GROUP BY territorio_atacado;

-- Objetivo 3: Filtrar os territórios com maior número de ataques. (Level 2)
SELECT territorio_atacado, COUNT(id) AS total_ataques
FROM ataques_detalhe
GROUP BY territorio_atacado
HAVING COUNT(id) > (
    SELECT AVG(contagem) FROM (
        SELECT COUNT(id) AS contagem FROM ataques_detalhe GROUP BY territorio_atacado
    ) AS sub
);

-- Objetivo 4: Identificar se houve variação no número de ataques antes e depois do surgimento do grupo. (Level 2)
WITH AtaquesPorAno AS (
    SELECT EXTRACT(YEAR FROM data_ocorrido) AS ano, COUNT(id) AS num_ataques
    FROM ataques_detalhe
    GROUP BY ano
)
SELECT
    ano,
    num_ataques,
    LAG(num_ataques, 1, 0) OVER (ORDER BY ano) AS ataques_ano_anterior,
    num_ataques - LAG(num_ataques, 1, 0) OVER (ORDER BY ano) AS variacao
FROM AtaquesPorAno
ORDER BY ano;

-- Objetivo 5: Consultar visão protegida sobre vínculos suspeitos entre espécies e Justiceiros. (Level 1)
SELECT * FROM vinculos_suspeitos;

-- =====================================================================
-- CAPÍTULO 3: TRAÇOS DE CONSPIRAÇÃO [NÍVEL MÁXIMO: 3]
-- =====================================================================

-- Objetivo 1: Cruzar dados de exportações e importações entre territórios para identificar rotas usadas pelos Justiceiros. (Level 3)
SELECT
    f_origem.familiaFeudal AS origem,
    f_destino.familiaFeudal AS destino,
    t.recurso,
    t.data_transacao
FROM transacoes_base t
JOIN Feudo f_origem ON t.id_territorio_origem = f_origem.id
JOIN Feudo f_destino ON t.id_territorio_destino = f_destino.id;

-- Objetivo 2: Filtrar somente as transações que envolvem recursos usados em ataques (ex.: pedras flamejantes). (Level 3)
SELECT *
FROM Transacoes_Comerciais
WHERE recurso = 'pedras flamejantes';

-- Objetivo 3: Localizar registros de troca de artefatos lendários entre territórios. (Level 3)
SELECT
    v.nome_artefato,
    f.familiaFeudal AS territorio_atual
FROM posse_artefatos_base v
JOIN Pessoa p ON v.id_personagem_portador = p.id
JOIN Cidade c ON p.id = c.id_pessoa
JOIN Feudo f ON c.id_feudo = f.id
WHERE v.categoria = 'L';

-- Objetivo 4: Listar todos os envolvidos com acesso a minas de pedras flamejantes. (Level 3)
SELECT
    p.nome AS nome_envolvido,
    p.sobreNome AS sobrenome_envolvido,
    m.recurso_principal AS mina_recurso
FROM mineracao_base v
JOIN Pessoa p ON v.id_pessoa = p.id
JOIN Minas m ON v.id_mina = m.id
WHERE m.recurso_principal = 'pedras flamejantes';

-- Objetivo 5: Investigar transações comerciais autorizadas por Senhores das Terras e cruzar com ataques posteriores. (Level 3)
SELECT
    p_autorizador.nome AS senhor_autorizador,
    tc.recurso,
    a.data_ocorrido AS data_ataque
FROM Transacoes_Comerciais tc
JOIN Pessoa p_autorizador ON tc.id_senhor_autorizador = p_autorizador.id
JOIN Ataques a ON tc.id_territorio_destino = a.id_territorio
WHERE a.data_ocorrido > tc.data_transacao;

-- =====================================================================
-- CAPÍTULO 4: A MÁSCARA DO SEM NOME [NÍVEL MÁXIMO: 4]
-- =====================================================================

-- Objetivo 1: Relacionar ataques de maior impacto com ordens emitidas pela Torre Mágica. (Level 4)
SELECT
    ot.descricao_ordem,
    a.data_ocorrido AS data_ataque,
    a.nivel_impacto
FROM ordens_torre_base ot
JOIN Ataques a ON ot.id_territorio_alvo = a.id_territorio
WHERE a.nivel_impacto > 8 AND ot.data_emissao < a.data_ocorrido;

-- Objetivo 2: Calcular a média de recursos usados em ataques por ano. (Level 2)
SELECT EXTRACT(YEAR FROM data_ocorrido) AS ano, AVG(quantidade_recursos) AS media_recursos
FROM recursos_ataques_base
GROUP BY ano;

-- Objetivo 3: Filtrar somente ataques onde a origem dos recursos seja o território de Val’Nareth. (Level 3)
SELECT *
FROM ataques_origem_recurso
WHERE territorio_origem_recurso = 'Val’Nareth';

-- Objetivo 4: Identificar aliados políticos e militares do Senhor da Torre. (Level 4)
SELECT
    p1.nome AS senhor_da_torre,
    p2.nome AS aliado
FROM Pessoa p1
JOIN Torres_Magicas tm ON p1.id = tm.id_senhor_da_torre
JOIN aliancas_raw al ON p1.id = al.id_personagem1
JOIN Pessoa p2 ON al.id_personagem2 = p2.id
WHERE tm.nome = 'Torre Mágica de Val’Nareth';

-- Objetivo 5: Gerar ranking de territórios mais afetados desde o surgimento do Sem Nome. (Level 4)
SELECT
    f.familiaFeudal AS territorio,
    COUNT(a.id) AS total_ataques
FROM Ataques a
JOIN Feudo f ON a.id_territorio = f.id
WHERE a.data_ocorrido > '535-01-01' -- Data hipotética do surgimento do "Sem Nome"
GROUP BY f.familiaFeudal
ORDER BY total_ataques DESC;

-- =====================================================================
-- CAPÍTULO 5: O HEXADECIMAL E O GRIMÓRIO [NÍVEL MÁXIMO: 4]
-- =====================================================================

-- Objetivo 1: Localizar registros em hexadecimal ligados à Torre Mágica de Val’Nareth. (Level 4)
SELECT conteudo_hex
FROM registros_hex_raw
WHERE nome_torre = 'Torre Mágica de Val’Nareth';

-- Objetivo 2: Decodificar a informação para extrair o atributo torremagoValNareth. (Level 4)
SELECT ENCODE(DECODE(conteudo_hex, 'hex'), 'escape') AS informacao_decodificada
FROM registros_hex_raw
WHERE nome_torre = 'Torre Mágica de Val’Nareth';

-- Objetivo 3: Verificar todas as ordens emitidas pelo líder dos Justiceiros contendo esse atributo. (Level 4)
SELECT *
FROM ordens_emitidas_raw
WHERE id_emissor = (SELECT id FROM Pessoa WHERE nome = 'Líder dos Justiceiros')
AND conteudo_ordem LIKE '%' || (
    SELECT ENCODE(DECODE(conteudo_hex, 'hex'), 'escape')
    FROM registros_hex_raw
    WHERE nome_torre = 'Torre Mágica de Val’Nareth'
    LIMIT 1
) || '%';

-- Objetivo 4: Conferir a posse atual do Cajado do Coração de Fogo. (Level 3)
SELECT nome_portador, sobrenome_portador
FROM posse_artefato_personagem
WHERE nome_artefato = 'Cajado do Coração de Fogo';

-- Objetivo 5: Revelar o conteúdo da visão final contendo o Grimório Primordial. (Level 4)
SELECT *
FROM grimorio_final;
