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
( 1, 1, 'regioes_reinos'),
( 2, 1, 'especies_governantes'),
( 3, 1, 'senhores_das_terras'),
( 4, 1, 'artefatos_por_territorio'),
( 5, 1, 'pessoas_vivas'),
-- Capítulo 2: investigação dos ataques
( 6, 2, 'ataques_raw'),
( 7, 2, 'ataques_detalhe'),
( 8, 2, 'vinculos_suspeitos'),
-- Capítulo 3: rastreamento de recursos e conspirações
( 9, 3, 'transacoes_base'),
(10, 3, 'posse_artefatos_base'),
(11, 3, 'mineracao_base'),
(12, 3, 'ordens_torre_base'),
(13, 3, 'recursos_ataques_base'),
(14, 3, 'ataques_origem_recurso'),
(15, 3, 'aliancas_raw'),
-- Capítulo 4: reutiliza views do capítulo 3 — registradas aqui para getByCapituloId(4)
(20, 4, 'ordens_torre_base'),
(21, 4, 'recursos_ataques_base'),
(22, 4, 'ataques_origem_recurso'),
(23, 4, 'aliancas_raw'),
-- Capítulo 5: desvendando o grimório
(16, 5, 'registros_hex_raw'),
(17, 5, 'ordens_emitidas_raw'),
(18, 5, 'posse_artefato_personagem'),
(19, 5, 'grimorio_final');

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

-- Capítulo 2: PRIMEIRAS PISTAS DOS JUSTICEIROS (5 objetivos, foco: GROUP BY e Window Functions)
INSERT INTO Objetivo (id, id_capitulo, descricao, ordem, nivel) VALUES
(7,  2, 'Localizar todos os registros de ataques atribuídos aos Justiceiros e contá-los.', 1, 2),
(8,  2, 'Agrupar os ataques por território e contar a quantidade de ocorrências em cada um.', 2, 2),
(9,  2, 'Filtrar apenas os territórios com número de ataques acima da média geral.', 3, 4),
(10, 2, 'Identificar a variação anual no número de ataques usando LAG() em uma CTE.', 4, 4),
(11, 2, 'Consultar a view de vínculos suspeitos entre espécies e territórios dos Justiceiros.', 5, 0);

-- Capítulo 3: TRAÇOS DE CONSPIRAÇÃO (5 objetivos, foco: JOINs múltiplos)
INSERT INTO Objetivo (id, id_capitulo, descricao, ordem, nivel) VALUES
(12, 3, 'Cruzar exportações e importações entre territórios para mapear as rotas usadas.', 1, 3),
(13, 3, 'Filtrar somente as transações que envolvem "pedras flamejantes".', 2, 3),
(14, 3, 'Localizar registros de troca de artefatos lendários entre territórios e personagens.', 3, 3),
(15, 3, 'Listar todos os personagens com acesso a minas de pedras flamejantes.', 4, 3),
(16, 3, 'Investigar transações autorizadas por Senhores das Terras cruzando com ataques posteriores.', 5, 4);

-- Capítulo 4: A MÁSCARA DO SEM NOME (5 objetivos, foco: subqueries e JOINs complexos)
INSERT INTO Objetivo (id, id_capitulo, descricao, ordem, nivel) VALUES
(17, 4, 'Relacionar ataques de maior impacto (nível > 8) com ordens emitidas pela Torre Mágica.', 1, 4),
(18, 4, 'Calcular a média de recursos usados em ataques agrupada por ano.', 2, 4),
(19, 4, 'Filtrar ataques cuja origem dos recursos seja o território de Val Nareth.', 3, 4),
(20, 4, 'Identificar os aliados políticos do Senhor da Torre Mágica de Val Nareth.', 4, 4),
(21, 4, 'Gerar ranking dos territórios mais afetados desde o surgimento do Sem Nome (após 535 d.C.).', 5, 4);

-- Capítulo 5: O HEXADECIMAL E O GRIMÓRIO (5 objetivos, foco: funções avançadas e subconsultas)
INSERT INTO Objetivo (id, id_capitulo, descricao, ordem, nivel) VALUES
(22, 5, 'Recuperar o código hexadecimal guardado na Torre Mágica de Val Nareth.', 1, 1),
(23, 5, 'Decodificar o hexadecimal para obter a palavra-chave secreta usando ENCODE e DECODE.', 2, 4),
(24, 5, 'Encontrar ordens emitidas pelo Líder dos Justiceiros que mencionam a palavra-chave decifrada.', 3, 4),
(25, 5, 'Identificar o portador atual do Cajado do Coração de Fogo.', 4, 3),
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
-- CONSULTAS-SOLUÇÃO POR CAPÍTULO
-- Uma consulta por capítulo: o SQL que o jogador deve produzir.
-- 'colunas' lista os nomes das colunas esperadas no resultado.
-- 'resultado' pode ser populado após rodar a query no banco do jogo.
-- ============================================================
INSERT INTO Consulta (id, id_capitulo, query, colunas, resultado) VALUES

(1, 1,
 'SELECT f.familiaFeudal AS nome_reino, f.geografia, '
 'p.nome AS nome_senhor, p.sobreNome AS sobrenome_senhor '
 'FROM Feudo f '
 'JOIN Cidade c ON f.id = c.id_feudo '
 'JOIN Pessoa p ON c.id_pessoa = p.id '
 'ORDER BY f.familiaFeudal;',
 '["nome_reino", "geografia", "nome_senhor", "sobrenome_senhor"]'::jsonb,
 NULL),

(2, 2,
 'WITH AtaquesPorAno AS ('
 '  SELECT EXTRACT(YEAR FROM data_ocorrido) AS ano, COUNT(id) AS num_ataques '
 '  FROM ataques_detalhe GROUP BY ano'
 ') '
 'SELECT ano, num_ataques, '
 'LAG(num_ataques, 1, 0) OVER (ORDER BY ano) AS ataques_ano_anterior, '
 'num_ataques - LAG(num_ataques, 1, 0) OVER (ORDER BY ano) AS variacao '
 'FROM AtaquesPorAno ORDER BY ano;',
 '["ano", "num_ataques", "ataques_ano_anterior", "variacao"]'::jsonb,
 NULL),

(3, 3,
 'SELECT p_autorizador.nome AS senhor_autorizador, tc.recurso, a.data_ocorrido AS data_ataque '
 'FROM Transacoes_Comerciais tc '
 'JOIN Pessoa p_autorizador ON tc.id_senhor_autorizador = p_autorizador.id '
 'JOIN Ataques a ON tc.id_territorio_destino = a.id_territorio '
 'WHERE a.data_ocorrido > tc.data_transacao;',
 '["senhor_autorizador", "recurso", "data_ataque"]'::jsonb,
 NULL),

(4, 4,
 'SELECT p1.nome AS senhor_da_torre, p2.nome AS aliado '
 'FROM Pessoa p1 '
 'JOIN Torres_Magicas tm ON p1.id = tm.id_senhor_da_torre '
 'JOIN aliancas_raw al ON p1.id = al.id_personagem1 '
 'JOIN Pessoa p2 ON al.id_personagem2 = p2.id '
 'WHERE tm.nome = ''Torre Mágica de Val Nareth'';',
 '["senhor_da_torre", "aliado"]'::jsonb,
 NULL),

(5, 5,
 'SELECT * FROM grimorio_final;',
 '["conteudo"]'::jsonb,
 NULL);
