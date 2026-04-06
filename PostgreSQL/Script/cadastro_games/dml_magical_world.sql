-- ============================================================
-- DML - Mundo Mágico
-- Popula o banco db_gestao com o conteúdo do jogo.
-- Execute APÓS o ddl_structure.sql estar aplicado.
-- Data: 2026-03-22
-- ============================================================

-- Limpa todas as tabelas em ordem segura (FK)
TRUNCATE TABLE Log, Dica, Consulta, Objetivo, Visao, Capitulo, Desafio
    RESTART IDENTITY CASCADE;

-- ============================================================
-- DESAFIO
-- Um único desafio contém os 5 capítulos do Mistério do Mundo Mágico.
-- ============================================================
INSERT INTO Desafio (id, titulo, descricao, tempo_estimado, taxa_conclusao) VALUES
(1,
 'Mistério do Mundo Mágico',
 'Um investigador é convocado para resolver uma conspiração que ameaça a paz entre os reinos. '
 'Ao longo de 5 capítulos, você usará SQL para mapear territórios, rastrear recursos, '
 'identificar traidores e decifrar segredos codificados — até revelar a verdade oculta no Grimório Primordial.',
 '5 a 10 horas',
 0);

-- ============================================================
-- CAPÍTULOS
-- Cada capítulo tem: narrativa de introdução, contexto investigativo e XP de recompensa.
-- ============================================================
INSERT INTO Capitulo (id, id_desafio, numero, intro_historia, contexto_historia, xp_recompensa) VALUES

(1, 1, 1,
 'O mundo mágico vive sob a sombra do preconceito e da desconfiança, '
 'um caos alimentado por lendas e guerras antigas. Como investigador '
 'encarregado de restaurar a paz, você recebe sua primeira missão.',
 'Mapeie as regiões e reinos do mundo mágico. Identifique as espécies que governam cada '
 'território, os Senhores das Terras nomeados pela realeza e os artefatos lendários que são '
 'pivô de muitos conflitos. Explore as VIEWs disponíveis usando SELECT e WHERE.',
 100),

(2, 1, 2,
 'Um grupo extremista de bruxos, autointitulado "Os Justiceiros", está espalhando o terror '
 'com atentados brutais — incluindo a explosão de uma Academia Mágica. '
 'Para combatê-los, é preciso entender seu padrão de operação.',
 'Mergulhe nos registros de ataques atribuídos ao grupo. Analise onde atacam, '
 'com que frequência e se há variação temporal. Use GROUP BY, HAVING e funções de janela '
 'para encontrar o epicentro das atividades dos Justiceiros.',
 200),

(3, 1, 3,
 'Ataques dessa magnitude exigem planejamento, recursos e cúmplices. '
 'Os Justiceiros não agem sozinhos. Siga o rastro das "pedras flamejantes" '
 'usadas em seus explosivos — alguém está financiando a conspiração.',
 'Investigue as transações comerciais entre territórios. Identifique rotas de suprimento, '
 'quem autoriza as movimentações de recursos e como os artefatos lendários trocam de mãos. '
 'Use JOINs entre múltiplas tabelas para conectar as evidências.',
 300),

(4, 1, 4,
 'As pistas apontam para um único nome — ou melhor, para um indivíduo que não tem nome. '
 '"O Sem Nome", Senhor da Torre Mágica de Val Nareth, é o verdadeiro cérebro da conspiração. '
 'Mas provar isso exige evidências sólidas.',
 'Conecte as ordens emitidas pela Torre Mágica de Val Nareth aos ataques dos Justiceiros. '
 'Identifique os aliados do Senhor da Torre e exponha a hierarquia da conspiração. '
 'Use subqueries, CTEs e JOINs complexos para desvendar a rede de cumplicidade.',
 400),

(5, 1, 5,
 'Com a captura do líder dos Justiceiros, uma pista enigmática é descoberta: '
 'um registro secreto codificado em hexadecimal nos arquivos da Torre de Val Nareth. '
 'Este código é a chave para a verdade final.',
 'Encontre o registro hexadecimal, decodifique-o para obter a palavra-chave secreta '
 'e use essa informação para localizar o perdido Grimório Primordial. '
 'O Grimório contém a história completa da conspiração. Use ENCODE, DECODE, LIKE e subconsultas.',
 500);

-- ============================================================
-- VISÕES DISPONÍVEIS POR CAPÍTULO
-- Cada VIEW pertence ao capítulo onde é introduzida pela primeira vez.
-- O campo 'comando' é o nome da VIEW no banco do jogo (db_game).
-- ============================================================
INSERT INTO Visao (id, id_capitulo, comando) VALUES
-- Capítulo 1: mapeamento do mundo
( 1, 1, 'magical_world.regioes_reinos'),
( 2, 1, 'magical_world.especies_governantes'),
( 3, 1, 'magical_world.senhores_das_terras'),
( 4, 1, 'magical_world.artefatos_por_territorio'),
( 5, 1, 'magical_world.pessoas_vivas'),
-- Capítulo 2: investigação dos ataques
( 6, 2, 'magical_world.ataques_raw'),
( 7, 2, 'magical_world.ataques_detalhe'),
( 8, 2, 'magical_world.vinculos_suspeitos'),
-- Capítulo 3: rastreamento de recursos e conspirações
( 9, 3, 'magical_world.transacoes_base'),
(10, 3, 'magical_world.posse_artefatos_base'),
(11, 3, 'magical_world.mineracao_base'),
(12, 3, 'magical_world.ordens_torre_base'),
(13, 3, 'magical_world.recursos_ataques_base'),
(14, 3, 'magical_world.ataques_origem_recurso'),
(15, 3, 'magical_world.aliancas_raw'),
-- Capítulo 4: reutiliza views do capítulo 3 — registradas aqui para getByCapituloId(4)
(20, 4, 'magical_world.ordens_torre_base'),
(21, 4, 'magical_world.recursos_ataques_base'),
(22, 4, 'magical_world.ataques_origem_recurso'),
(23, 4, 'magical_world.aliancas_raw'),
-- Capítulo 5: desvendando o grimório
(16, 5, 'magical_world.registros_hex_raw'),
(17, 5, 'magical_world.ordens_emitidas_raw'),
(18, 5, 'magical_world.posse_artefato_personagem'),
(19, 5, 'magical_world.grimorio_final');

-- ============================================================
-- OBJETIVOS POR CAPÍTULO
-- Cada objetivo é uma tarefa SQL com ordem de execução dentro do capítulo.
-- ============================================================

-- Capítulo 1: MAPEANDO O MUNDO MÁGICO (6 objetivos, foco: SELECT e WHERE)
INSERT INTO Objetivo (id, id_capitulo, descricao, ordem, nivel) VALUES
(1, 1, 'Identificar todas as regiões e reinos do mundo mágico listados no banco de dados.', 1, 0),
(2, 1, 'Listar as espécies que governam cada território.', 2, 0),
(3, 1, 'Encontrar o nome e sobrenome dos Senhores das Terras de cada território.', 3, 0),
(4, 1, 'Verificar quais territórios possuem ligação com artefatos da categoria Lendário (''L'').', 4, 1),
(5, 1, 'Explorar as regiões com geografia Norte (''N'') e Sul (''S'') usando WHERE com OR.', 5, 1),
(6, 1, 'Identificar a pessoa mais antiga ainda viva, obtendo seu nome e idade calculada.', 6, 2);

-- Capítulo 2: PRIMEIRAS PISTAS DOS JUSTICEIROS (5 objetivos, foco: GROUP BY e HAVING)
INSERT INTO Objetivo (id, id_capitulo, descricao, ordem, nivel) VALUES
(7,  2, 'Filtrar apenas os ataques cujo autor é "Os Justiceiros" usando WHERE.', 1, 1),
(8,  2, 'Agrupar os ataques por território e contar quantas vezes cada um foi atacado.', 2, 2),
(9,  2, 'Filtrar os territórios que sofreram mais de um ataque usando HAVING.', 3, 2),
(10, 2, 'Listar todos os ataques detalhados, ordenados do mais recente para o mais antigo.', 4, 1),
(11, 2, 'Consultar os vínculos suspeitos entre espécies e territórios.', 5, 0);

-- Capítulo 3: TRAÇOS DE CONSPIRAÇÃO (5 objetivos, foco: filtros em múltiplas views)
INSERT INTO Objetivo (id, id_capitulo, descricao, ordem, nivel) VALUES
(12, 3, 'Listar todas as transações comerciais entre territórios, ordenadas pela origem.', 1, 1),
(13, 3, 'Filtrar somente as transações que envolvem "pedras flamejantes".', 2, 1),
(14, 3, 'Localizar registros de artefatos da categoria Lendário que trocaram de mãos.', 3, 1),
(15, 3, 'Listar as permissões de mineração relacionadas a "pedras flamejantes".', 4, 1),
(16, 3, 'Listar todas as transações que possuem um senhor autorizador, ordenadas por data.', 5, 2);

-- Capítulo 4: A MÁSCARA DO SEM NOME (5 objetivos, foco: GROUP BY e ORDER BY avançados)
INSERT INTO Objetivo (id, id_capitulo, descricao, ordem, nivel) VALUES
(17, 4, 'Listar todas as ordens emitidas pela Torre Mágica, ordenadas por data de emissão.', 1, 1),
(18, 4, 'Contar o total de ataques e somar os recursos usados, agrupando por território.', 2, 2),
(19, 4, 'Encontrar ataques cuja origem de recursos contenha "Val" no nome do território.', 3, 2),
(20, 4, 'Listar todos os vínculos de aliança registrados no banco de dados.', 4, 0),
(21, 4, 'Gerar ranking dos territórios com mais ataques registrados.', 5, 2);

-- Capítulo 5: O HEXADECIMAL E O GRIMÓRIO (5 objetivos, foco: filtros e descoberta final)
INSERT INTO Objetivo (id, id_capitulo, descricao, ordem, nivel) VALUES
(22, 5, 'Recuperar o registro secreto da Torre Mágica de Val Nareth.', 1, 1),
(23, 5, 'Explorar todos os registros secretos disponíveis no banco de dados.', 2, 0),
(24, 5, 'Listar todas as ordens emitidas para descobrir pistas sobre a conspiração.', 3, 0),
(25, 5, 'Identificar o portador atual do Cajado do Coração de Fogo.', 4, 1),
(26, 5, 'Acessar o Grimório Primordial e revelar a verdade completa sobre a conspiração.', 5, 0);

-- ============================================================
-- DICAS POR CAPÍTULO
-- Cada capítulo tem 3 dicas em ordem crescente de especificidade.
-- Mais específica = maior penalidade de XP.
-- ============================================================

-- Capítulo 1
INSERT INTO Dica (id, id_capitulo, ordem, conteudo, penalidade_xp) VALUES
(1, 1, 1,
 'Use a VIEW "regioes_reinos" para listar os reinos e geografias. '
 'Experimente: SELECT * FROM regioes_reinos;',
 10),
(2, 1, 2,
 'A VIEW "senhores_das_terras" já une Pessoa, Cidade e Feudo. '
 'Combine-a com "regioes_reinos" para enriquecer o resultado.',
 25),
(3, 1, 3,
 'Query completa: SELECT f.familiaFeudal AS nome_reino, f.geografia, '
 'p.nome AS nome_senhor, p.sobreNome AS sobrenome_senhor '
 'FROM Feudo f JOIN Cidade c ON f.id = c.id_feudo '
 'JOIN Pessoa p ON c.id_pessoa = p.id ORDER BY f.familiaFeudal;',
 50);

-- Capítulo 2
INSERT INTO Dica (id, id_capitulo, ordem, conteudo, penalidade_xp) VALUES
(4, 2, 1,
 'Filtre a VIEW "ataques_raw" com WHERE autor = ''Os Justiceiros'' '
 'para ver apenas os ataques do grupo.',
 10),
(5, 2, 2,
 'Use GROUP BY sobre "ataques_detalhe" para agrupar por territorio_atacado '
 'e COUNT(id) para contar ocorrências. Adicione HAVING COUNT(id) > média para filtrar.',
 25),
(6, 2, 3,
 'Para variação anual, crie uma CTE: WITH AtaquesPorAno AS (SELECT EXTRACT(YEAR FROM data_ocorrido) '
 'AS ano, COUNT(id) AS num_ataques FROM ataques_detalhe GROUP BY ano) '
 'SELECT ano, num_ataques, LAG(num_ataques, 1, 0) OVER (ORDER BY ano) AS ataques_ano_anterior, '
 'num_ataques - LAG(num_ataques, 1, 0) OVER (ORDER BY ano) AS variacao FROM AtaquesPorAno ORDER BY ano;',
 50);

-- Capítulo 3
INSERT INTO Dica (id, id_capitulo, ordem, conteudo, penalidade_xp) VALUES
(7, 3, 1,
 'Comece filtrando Transacoes_Comerciais pelo campo recurso: '
 'SELECT * FROM Transacoes_Comerciais WHERE recurso = ''pedras flamejantes'';',
 10),
(8, 3, 2,
 'Para rastrear quem autorizou as transações, use JOIN entre transacoes_base, '
 'Feudo (origem e destino) e Pessoa (id_senhor_autorizador).',
 25),
(9, 3, 3,
 'Para cruzar transações com ataques posteriores: '
 'SELECT p.nome AS senhor_autorizador, tc.recurso, a.data_ocorrido AS data_ataque '
 'FROM Transacoes_Comerciais tc '
 'JOIN Pessoa p ON tc.id_senhor_autorizador = p.id '
 'JOIN Ataques a ON tc.id_territorio_destino = a.id_territorio '
 'WHERE a.data_ocorrido > tc.data_transacao;',
 50);

-- Capítulo 4
INSERT INTO Dica (id, id_capitulo, ordem, conteudo, penalidade_xp) VALUES
(10, 4, 1,
 'A VIEW "ordens_torre_base" contém ordens da Torre Mágica. '
 'Filtre por id_territorio_alvo para cruzar com ataques de alto impacto (nivel_impacto > 8).',
 10),
(11, 4, 2,
 'Para encontrar aliados do Senhor da Torre, junte Torres_Magicas, Aliados_Politicos e Pessoa. '
 'Filtre WHERE tm.nome = ''Torre Mágica de Val Nareth''.',
 25),
(12, 4, 3,
 'Query dos aliados: SELECT p1.nome AS senhor_da_torre, p2.nome AS aliado '
 'FROM Pessoa p1 '
 'JOIN Torres_Magicas tm ON p1.id = tm.id_senhor_da_torre '
 'JOIN aliancas_raw al ON p1.id = al.id_personagem1 '
 'JOIN Pessoa p2 ON al.id_personagem2 = p2.id '
 'WHERE tm.nome = ''Torre Mágica de Val Nareth'';',
 50);

-- Capítulo 5
INSERT INTO Dica (id, id_capitulo, ordem, conteudo, penalidade_xp) VALUES
(13, 5, 1,
 'Use a VIEW "registros_hex_raw" para encontrar o hexadecimal: '
 'SELECT conteudo_hex FROM registros_hex_raw WHERE nome_torre = ''Torre Mágica de Val Nareth'';',
 10),
(14, 5, 2,
 'Decodifique o hexadecimal com: '
 'SELECT ENCODE(DECODE(conteudo_hex, ''hex''), ''escape'') AS palavra_chave '
 'FROM registros_hex_raw WHERE nome_torre = ''Torre Mágica de Val Nareth'';',
 25),
(15, 5, 3,
 'Query completa do Cap 5: '
 'SELECT * FROM ordens_emitidas_raw '
 'WHERE conteudo_ordem LIKE ''%'' || '
 '(SELECT ENCODE(DECODE(conteudo_hex,''hex''),''escape'') '
 ' FROM registros_hex_raw WHERE nome_torre = ''Torre Mágica de Val Nareth'' LIMIT 1) '
 '|| ''%'' '
 'AND id_emissor = (SELECT id FROM Pessoa WHERE nome || '' '' || sobreNome = ''Líder dos Justiceiros''); '
 'Depois: SELECT * FROM grimorio_final;',
 50);

-- ============================================================
-- CONSULTAS-SOLUÇÃO POR OBJETIVO
-- Uma consulta por objetivo: SQL progressivo que o jogador deve produzir.
-- Nível 0 = SELECT simples | Nível 1 = WHERE | Nível 2 = GROUP BY / ORDER BY
-- Nível 3 = JOINs          | Nível 4 = CTEs / Subqueries / Window Functions
-- ============================================================

-- ─── CAPÍTULO 1: SELECT e WHERE ───────────────────────────────────────────────

-- Obj 1 (nivel 0): SELECT * simples
INSERT INTO Consulta (id, id_capitulo, id_objetivo, query, colunas, resultado) VALUES
(1, 1, 1,
 'SELECT * FROM regioes_reinos;',
 '["nome_reino", "geografia"]'::jsonb,
 NULL);

-- Obj 2 (nivel 0): SELECT * simples
INSERT INTO Consulta (id, id_capitulo, id_objetivo, query, colunas, resultado) VALUES
(2, 1, 2,
 'SELECT * FROM especies_governantes;',
 '["especie_governante"]'::jsonb,
 NULL);

-- Obj 3 (nivel 0): SELECT * simples
INSERT INTO Consulta (id, id_capitulo, id_objetivo, query, colunas, resultado) VALUES
(3, 1, 3,
 'SELECT * FROM senhores_das_terras;',
 '["nome_senhor", "sobrenome_senhor", "territorio_governado"]'::jsonb,
 NULL);

-- Obj 4 (nivel 1): WHERE simples
INSERT INTO Consulta (id, id_capitulo, id_objetivo, query, colunas, resultado) VALUES
(4, 1, 4,
 'SELECT * FROM artefatos_por_territorio WHERE categoria = ''L'';',
 '["nome_artefato", "categoria", "territorio_localizacao"]'::jsonb,
 NULL);

-- Obj 5 (nivel 1): WHERE com OR
INSERT INTO Consulta (id, id_capitulo, id_objetivo, query, colunas, resultado) VALUES
(5, 1, 5,
 'SELECT * FROM regioes_reinos WHERE geografia = ''N'' OR geografia = ''S'';',
 '["nome_reino", "geografia"]'::jsonb,
 NULL);

-- Obj 6 (nivel 2): ORDER BY + LIMIT
INSERT INTO Consulta (id, id_capitulo, id_objetivo, query, colunas, resultado) VALUES
(6, 1, 6,
 'SELECT * FROM pessoas_vivas ORDER BY nascimento ASC LIMIT 1;',
 '["nome", "sobreNome", "nascimento", "óbito"]'::jsonb,
 NULL);

-- ─── CAPÍTULO 2: GROUP BY e Window Functions ──────────────────────────────────

-- Obj 7 (nivel 2): COUNT total
INSERT INTO Consulta (id, id_capitulo, id_objetivo, query, colunas, resultado) VALUES
(7, 2, 7,
 'SELECT COUNT(*) AS total_ataques FROM ataques_raw WHERE autor = ''Os Justiceiros'';',
 '["total_ataques"]'::jsonb,
 NULL);

-- Obj 8 (nivel 2): GROUP BY + COUNT
INSERT INTO Consulta (id, id_capitulo, id_objetivo, query, colunas, resultado) VALUES
(8, 2, 8,
 'SELECT territorio_atacado, COUNT(*) AS total_ataques '
 'FROM ataques_detalhe '
 'GROUP BY territorio_atacado '
 'ORDER BY total_ataques DESC;',
 '["territorio_atacado", "total_ataques"]'::jsonb,
 NULL);

-- Obj 9 (nivel 2): HAVING com valor fixo
INSERT INTO Consulta (id, id_capitulo, id_objetivo, query, colunas, resultado) VALUES
(9, 2, 9,
 'SELECT territorio_atacado, COUNT(*) AS total_ataques '
 'FROM ataques_detalhe '
 'GROUP BY territorio_atacado '
 'HAVING COUNT(*) > 1 '
 'ORDER BY total_ataques DESC;',
 '["territorio_atacado", "total_ataques"]'::jsonb,
 NULL);

-- Obj 10 (nivel 1): ORDER BY simples
INSERT INTO Consulta (id, id_capitulo, id_objetivo, query, colunas, resultado) VALUES
(10, 2, 10,
 'SELECT * FROM ataques_detalhe ORDER BY data_ocorrido DESC;',
 '["id", "data_ocorrido", "territorio_atacado"]'::jsonb,
 NULL);

-- Obj 11 (nivel 0): SELECT * simples
INSERT INTO Consulta (id, id_capitulo, id_objetivo, query, colunas, resultado) VALUES
(11, 2, 11,
 'SELECT * FROM vinculos_suspeitos;',
 '["especie_associada", "territorio_associado"]'::jsonb,
 NULL);

-- ─── CAPÍTULO 3: JOINs múltiplos ──────────────────────────────────────────────

-- Obj 12 (nivel 3): Rotas de exportação/importação
INSERT INTO Consulta (id, id_capitulo, id_objetivo, query, colunas, resultado) VALUES
(12, 3, 12,
 'SELECT * FROM transacoes_base ORDER BY id_territorio_origem;',
 '["id_territorio_origem", "id_territorio_destino", "recurso", "data_transacao", "id_senhor_autorizador"]'::jsonb,
 NULL);

-- Obj 13 (nivel 3): Filtrar pedras flamejantes
INSERT INTO Consulta (id, id_capitulo, id_objetivo, query, colunas, resultado) VALUES
(13, 3, 13,
 'SELECT * FROM transacoes_base WHERE recurso = ''pedras flamejantes'';',
 '["id_territorio_origem", "id_territorio_destino", "recurso", "data_transacao", "id_senhor_autorizador"]'::jsonb,
 NULL);

-- Obj 14 (nivel 3): Artefatos lendários trocados
INSERT INTO Consulta (id, id_capitulo, id_objetivo, query, colunas, resultado) VALUES
(14, 3, 14,
 'SELECT * FROM posse_artefatos_base WHERE categoria = ''L'';',
 '["id_artefato", "id_personagem_portador", "data_posse", "nome_artefato", "categoria"]'::jsonb,
 NULL);

-- Obj 15 (nivel 3): Acesso a minas de pedras flamejantes
INSERT INTO Consulta (id, id_capitulo, id_objetivo, query, colunas, resultado) VALUES
(15, 3, 15,
 'SELECT * FROM mineracao_base WHERE recurso_principal = ''pedras flamejantes'';',
 '["id_mina", "id_pessoa", "recurso_principal"]'::jsonb,
 NULL);

-- Obj 16 (nivel 2): Filtro simples com ORDER BY
INSERT INTO Consulta (id, id_capitulo, id_objetivo, query, colunas, resultado) VALUES
(16, 3, 16,
 'SELECT * FROM transacoes_base '
 'WHERE id_senhor_autorizador IS NOT NULL '
 'ORDER BY data_transacao;',
 '["id_territorio_origem", "id_territorio_destino", "recurso", "data_transacao", "id_senhor_autorizador"]'::jsonb,
 NULL);

-- ─── CAPÍTULO 4: Subqueries e JOINs complexos ─────────────────────────────────

-- Obj 17 (nivel 1): Listar ordens da Torre com ORDER BY
INSERT INTO Consulta (id, id_capitulo, id_objetivo, query, colunas, resultado) VALUES
(17, 4, 17,
 'SELECT * FROM ordens_torre_base ORDER BY data_emissao;',
 '["id_ordem", "id_torre", "data_emissao", "id_territorio_alvo", "descricao_ordem"]'::jsonb,
 NULL);

-- Obj 18 (nivel 2): COUNT e SUM agrupados por território
INSERT INTO Consulta (id, id_capitulo, id_objetivo, query, colunas, resultado) VALUES
(18, 4, 18,
 'SELECT id_territorio, COUNT(*) AS total_ataques, SUM(quantidade_recursos) AS total_recursos '
 'FROM recursos_ataques_base '
 'GROUP BY id_territorio '
 'ORDER BY total_ataques DESC;',
 '["id_territorio", "total_ataques", "total_recursos"]'::jsonb,
 NULL);

-- Obj 19 (nivel 4): Ataques com origem em Val Nareth
INSERT INTO Consulta (id, id_capitulo, id_objetivo, query, colunas, resultado) VALUES
(19, 4, 19,
 'SELECT * FROM ataques_origem_recurso '
 'WHERE territorio_origem_recurso LIKE ''%Val%'';',
 '["data_ocorrido", "recurso_principal_usado", "territorio_origem_recurso"]'::jsonb,
 NULL);

-- Obj 20 (nivel 0): SELECT * simples
INSERT INTO Consulta (id, id_capitulo, id_objetivo, query, colunas, resultado) VALUES
(20, 4, 20,
 'SELECT * FROM aliancas_raw;',
 '["id_personagem1", "id_personagem2"]'::jsonb,
 NULL);

-- Obj 21 (nivel 2): GROUP BY + COUNT + ORDER BY
INSERT INTO Consulta (id, id_capitulo, id_objetivo, query, colunas, resultado) VALUES
(21, 4, 21,
 'SELECT id_territorio, COUNT(*) AS total_ataques '
 'FROM recursos_ataques_base '
 'GROUP BY id_territorio '
 'ORDER BY total_ataques DESC;',
 '["id_territorio", "total_ataques"]'::jsonb,
 NULL);

-- ─── CAPÍTULO 5: Funções avançadas e subconsultas ─────────────────────────────

-- Obj 22 (nivel 1): Recuperar hex da Torre de Val Nareth
INSERT INTO Consulta (id, id_capitulo, id_objetivo, query, colunas, resultado) VALUES
(22, 5, 22,
 'SELECT * FROM registros_hex_raw '
 'WHERE nome_torre = ''Torre Mágica de Val Nareth'';',
 '["conteudo_hex", "nome_torre"]'::jsonb,
 NULL);

-- Obj 23 (nivel 0): Explorar todos os registros secretos
INSERT INTO Consulta (id, id_capitulo, id_objetivo, query, colunas, resultado) VALUES
(23, 5, 23,
 'SELECT * FROM registros_hex_raw;',
 '["conteudo_hex", "nome_torre"]'::jsonb,
 NULL);

-- Obj 24 (nivel 0): Listar todas as ordens emitidas
INSERT INTO Consulta (id, id_capitulo, id_objetivo, query, colunas, resultado) VALUES
(24, 5, 24,
 'SELECT * FROM ordens_emitidas_raw;',
 '["id_emissor", "conteudo_ordem"]'::jsonb,
 NULL);

-- Obj 25 (nivel 3): Portador atual do Cajado do Coração de Fogo
INSERT INTO Consulta (id, id_capitulo, id_objetivo, query, colunas, resultado) VALUES
(25, 5, 25,
 'SELECT * FROM posse_artefato_personagem '
 'WHERE nome_artefato = ''Cajado do Coração de Fogo'';',
 '["id_artefato", "nome_portador", "sobrenome_portador", "nome_artefato"]'::jsonb,
 NULL);

-- Obj 26 (nivel 0): Revelar o Grimório Primordial
INSERT INTO Consulta (id, id_capitulo, id_objetivo, query, colunas, resultado) VALUES
(26, 5, 26,
 'SELECT * FROM grimorio_final;',
 '["conteudo"]'::jsonb,
 NULL);
