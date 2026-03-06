-- =============================================
-- DADOS DE EXEMPLO PARA O GESTÃO DB v2.1 (XP por Capítulo)
-- Agora com campo xp_recompensa por capítulo (Capitulo), seguindo o modelo correto.
-- =============================================

-- 1. DESAFIOS (Desafio)
INSERT INTO Desafio (id, titulo, descricao) VALUES
(1, 'MAPEANDO O MUNDO MÁGICO', 'O mundo mágico vive sob a sombra do preconceito e da desconfiança. Como investigador, sua missão é mapear regiões, identificar espécies governantes, reconhecer Senhores das Terras e localizar artefatos lendários.'),
(2, 'PRIMEIRAS PISTAS DOS JUSTICEIROS', 'Grupo extremista de bruxos espalha terror na Academia Mágica. Investigue padrões de ataques.');

-- 2. CAPÍTULOS (Capitulo) – agora inclui xp_recompensa!
INSERT INTO Capitulo (id, id_desafio, intro_historia, contexto_historia, numero, xp_recompensa) VALUES
(1, 1, 'MAPEANDO O MUNDO MÁGICO', 'O mundo mágico vive sob a sombra do preconceito e da desconfiança. Missão inicial: mapear situação.', 1, 100),
(2, 2, 'PRIMEIRAS PISTAS DOS JUSTICEIROS', 'Os Justiceiros são acusados de ataques brutais: investigue registros e padrões.', 2, 120);

-- 3. OBJETIVOS (Objetivo)
INSERT INTO Objetivo (id, id_capitulo, descricao, ordem) VALUES
(1, 1, 'Identificar todas as regiões e reinos do mundo mágico listados no banco de dados.', 1),
(2, 1, 'Listar as espécies que governam cada território.', 2),
(3, 2, 'Localizar todos os registros de ataques atribuídos aos Justiceiros.', 1);

-- 4. DICAS (Dica)
INSERT INTO Dica (id, id_capitulo, ordem, conteudo, penalidade_xp) VALUES
(1, 1, 1, 'Procure pela tabela de regiões principais.', 5),
(2, 1, 2, 'Leve em conta os artefatos lendários.', 10),
(3, 2, 1, 'Analise o local e frequência dos ataques.', 5);

-- 5. VISÃO (Visao) – uma por capítulo
INSERT INTO Visao (id, id_capitulo) VALUES
(1, 1),
(2, 2);

-- 6. VISÃO TABELA (Visao_Tabela) - Exemplo para capítulo 1
INSERT INTO Visao_Tabela (id, id_visao, nome, descricao) VALUES
(1, 1, 'regioes_reinos', 'Lista de regiões e reinos'),
(2, 1, 'especies_governantes', 'Espécies dominantes por território'),
(3, 2, 'ataques_raw', 'Registros de ataques bruxos');

-- 7. VISÃO COLUNA (Visao_Coluna) - Exemplo de colunas para regiõoes_reinos e ataques_raw (capítulo 1 e 2)
INSERT INTO Visao_Coluna (id, id_tabela, nome, tipo, nulavel, chave_primaria, descricao) VALUES
-- regioes_reinos (id_tabela=1)
(1, 1, 'nome_reino', 'VARCHAR', FALSE, FALSE, 'Nome do reino'),
(2, 1, 'geografia', 'VARCHAR', FALSE, FALSE, 'Descrição geográfica'),
-- ataques_raw (id_tabela=3)
(3, 3, 'data_ocorrido', 'DATE', FALSE, FALSE, 'Data do ataque'),
(4, 3, 'autor', 'VARCHAR', FALSE, FALSE, 'Autor do ataque'),
(5, 3, 'id_territorio', 'INTEGER', FALSE, FALSE, 'Identificador do território');

-- 8. VISÃO DADO EXEMPLO (Visao_DadoExemplo)
INSERT INTO Visao_DadoExemplo (id, id_tabela, dados) VALUES
(1, 1, '{"nome_reino": "Alven", "geografia": "Planícies"}'),
(2, 2, '{"especie_governante": "Duendes"}'),
(3, 3, '{"data_ocorrido": "2026-01-10", "autor": "Os Justiceiros", "id_territorio": 1}');

-- 9. CONSULTAS (Consulta) - Solução esperada (not query, but the expected rows)
INSERT INTO Consulta (id, id_capitulo, colunas, resultado) VALUES
-- Capítulo 1: lista de regiões e geografia esperada
(1, 1, ARRAY['nome_reino','geografia'], '[{"nome_reino": "Alven", "geografia": "Planícies"}]'),
-- Capítulo 2: ataques dos Justiceiros
(2, 2, ARRAY['data_ocorrido','id_territorio'], '[{"data_ocorrido": "2026-01-10", "id_territorio": 1}]');