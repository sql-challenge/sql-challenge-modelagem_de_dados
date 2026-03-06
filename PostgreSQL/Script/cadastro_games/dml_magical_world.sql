-- Inserindo os Capítulos do Jogo
INSERT INTO Capitulo (id, numero, titulo, nivelMaximo, descricao) VALUES
(1, 1, 'MAPEANDO O MUNDO MÁGICO', 1, 'O mundo mágico vive sob a sombra do preconceito e da desconfiança, um caos alimentado por lendas e guerras antigas. Como um investigador encarregado de restaurar a paz, sua primeira missão é obter um panorama completo da situação atual. É crucial mapear as diversas regiões, identificar as espécies que as governam e reconhecer os Senhores das Terras nomeados pela realeza. Fique atento também aos artefatos lendários, pois eles são o pivô de muitos conflitos históricos.'),
(2, 2, 'PRIMEIRAS PISTAS DOS JUSTICEIROS', 2, 'Um grupo extremista de bruxos, autointitulado "Os Justiceiros", está espalhando o terror com atentados brutais, como a explosão na Academia Mágica. Para combatê-los, é preciso primeiro entender seu modo de operação. Sua tarefa agora é mergulhar nos registros de ataques atribuídos ao grupo. Analise onde eles atacam, com que frequência e se há algum padrão em suas ações. Encontrar o epicentro de suas atividades é o primeiro passo para desvendar seus planos.'),
(3, 3, 'TRAÇOS DE CONSPIRAÇÃO', 3, 'Ataques dessa magnitude exigem planejamento, recursos e cúmplices. Os Justiceiros não poderiam agir sozinhos. Sua investigação agora deve focar nas conexões ocultas entre os territórios. Siga o rastro dos recursos, especialmente das "pedras flamejantes" usadas em seus explosivos. Investigue as transações comerciais, as rotas de suprimentos e quem autoriza essas movimentações. Uma aliança profana pode estar se escondendo por trás de acordos comerciais aparentemente legítimos.'),
(4, 4, 'A MÁSCARA DO SEM NOME', 4, 'As pistas sugerem que os Justiceiros são meros peões em um jogo muito maior. Há indícios de que um indivíduo extremamente poderoso e influente, um respeitado senhor da Torre Mágica de Val’Nareth, pode ser o verdadeiro cérebro por trás do caos. Conhecido apenas como "O Sem Nome" pelo medo que impõe, sua influência parece inquestionável. Sua missão é conectar as ordens emitidas por essa figura aos ataques dos Justiceiros, identificar seus aliados e expor a verdadeira hierarquia da conspiração.'),
(5, 5, 'O HEXADECIMAL E O GRIMÓRIO', 4, 'A investigação chegou ao seu clímax. Com a captura do líder dos Justiceiros, uma pista final e enigmática foi descoberta: um registro secreto, codificado em hexadecimal, localizado nos arquivos da Torre Mágica. Este código é a chave para a verdade final. Seu último desafio é encontrar este registro, decifrá-lo e usar a informação revelada para localizar o perdido Grimório Primordial. Apenas com ele em mãos, a história por trás de tudo será revelada e a paz poderá, finalmente, ser restaurada.');

-- Inserindo os Desafios (baseado nos Capítulos)
INSERT INTO Desafio (id, nome, descricao, id_capitulo) VALUES
(1, 'MAPEANDO O MUNDO MÁGICO', 'O mundo mágico vive sob a sombra do preconceito e da desconfiança, um caos alimentado por lendas e guerras antigas. Como um investigador encarregado de restaurar a paz, sua primeira missão é obter um panorama completo da situação atual. É crucial mapear as diversas regiões, identificar as espécies que as governam e reconhecer os Senhores das Terras nomeados pela realeza. Fique atento também aos artefatos lendários, pois eles são o pivô de muitos conflitos históricos.', 1),
(2, 'PRIMEIRAS PISTAS DOS JUSTICEIROS', 'Um grupo extremista de bruxos, autointitulado "Os Justiceiros", está espalhando o terror com atentados brutais, como a explosão na Academia Mágica. Para combatê-los, é preciso primeiro entender seu modo de operação. Sua tarefa agora é mergulhar nos registros de ataques atribuídos ao grupo. Analise onde eles atacam, com que frequência e se há algum padrão em suas ações. Encontrar o epicentro de suas atividades é o primeiro passo para desvendar seus planos.', 2),
(3, 'TRAÇOS DE CONSPIRAÇÃO', 'Ataques dessa magnitude exigem planejamento, recursos e cúmplices. Os Justiceiros não poderiam agir sozinhos. Sua investigação agora deve focar nas conexões ocultas entre os territórios. Siga o rastro dos recursos, especialmente das "pedras flamejantes" usadas em seus explosivos. Investigue as transações comerciais, as rotas de suprimentos e quem autoriza essas movimentações. Uma aliança profana pode estar se escondendo por trás de acordos comerciais aparentemente legítimos.', 3),
(4, 'A MÁSCARA DO SEM NOME', 'As pistas sugerem que os Justiceiros são meros peões em um jogo muito maior. Há indícios de que um indivíduo extremamente poderoso e influente, um respeitado senhor da Torre Mágica de Val’Nareth, pode ser o verdadeiro cérebro por trás do caos. Conhecido apenas como "O Sem Nome" pelo medo que impõe, sua influência parece inquestionável. Sua missão é conectar as ordens emitidas por essa figura aos ataques dos Justiceiros, identificar seus aliados e expor a verdadeira hierarquia da conspiração.', 4),
(5, 'O HEXADECIMAL E O GRIMÓRIO', 'A investigação chegou ao seu clímax. Com a captura do líder dos Justiceiros, uma pista final e enigmática foi descoberta: um registro secreto, codificado em hexadecimal, localizado nos arquivos da Torre Mágica. Este código é a chave para a verdade final. Seu último desafio é encontrar este registro, decifrá-lo e usar a informação revelada para localizar o perdido Grimório Primordial. Apenas com ele em mãos, a história por trás de tudo será revelada e a paz poderá, finalmente, ser restaurada.', 5);

-- Inserindo as Visões (Nomes das views/tabelas para o jogador)
INSERT INTO Visao (id, comando) VALUES
(1, 'regioes_reinos'),
(2, 'especies_governantes'),
(3, 'senhores_das_terras'),
(4, 'artefatos_por_territorio'),
(5, 'pessoas_vivas'),
(6, 'ataques_raw'),
(7, 'ataques_detalhe'),
(8, 'vinculos_suspeitos'),
(9, 'transacoes_base'),
(10, 'posse_artefatos_base'),
(11, 'mineracao_base'),
(12, 'ordens_torre_base'),
(13, 'recursos_ataques_base'),
(14, 'ataques_origem_recurso'),
(15, 'aliancas_raw'),
(16, 'registros_hex_raw'),
(17, 'ordens_emitidas_raw'),
(18, 'posse_artefato_personagem'),
(19, 'grimorio_final');

-- Inserindo as Consultas (Soluções) do Jogo
INSERT INTO Consulta (id, query) VALUES
-- Capítulo 1
(1, 'SELECT nome_reino, geografia FROM regioes_reinos;'),
(2, 'SELECT especie_governante FROM especies_governantes;'),
(3, 'SELECT nome_senhor, sobrenome_senhor, territorio_governado FROM senhores_das_terras;'),
(4, 'SELECT nome_artefato, territorio_localizacao FROM artefatos_por_territorio WHERE categoria = ''L'';'),
(5, 'SELECT * FROM regioes_reinos; SELECT * FROM senhores_das_terras;'),
(6, 'SELECT nome, sobreNome, EXTRACT(YEAR FROM AGE(CURRENT_DATE, nascimento)) AS idade_atual FROM pessoas_vivas WHERE óbito IS NULL ORDER BY nascimento ASC LIMIT 1;'),
-- Capítulo 2
(7, 'SELECT data_ocorrido, id_territorio FROM ataques_raw WHERE autor = ''Os Justiceiros'';'),
(8, 'SELECT territorio_atacado, COUNT(id) AS total_ataques FROM ataques_detalhe GROUP BY territorio_atacado;'),
(9, 'SELECT territorio_atacado, COUNT(id) AS total_ataques FROM ataques_detalhe GROUP BY territorio_atacado HAVING COUNT(id) > (SELECT AVG(contagem) FROM (SELECT COUNT(id) AS contagem FROM ataques_detalhe GROUP BY territorio_atacado) AS sub);'),
(10, 'WITH AtaquesPorAno AS (SELECT EXTRACT(YEAR FROM data_ocorrido) AS ano, COUNT(id) AS num_ataques FROM ataques_detalhe GROUP BY ano) SELECT ano, num_ataques, LAG(num_ataques, 1, 0) OVER (ORDER BY ano) AS ataques_ano_anterior, num_ataques - LAG(num_ataques, 1, 0) OVER (ORDER BY ano) AS variacao FROM AtaquesPorAno ORDER BY ano;'),
(11, 'SELECT * FROM vinculos_suspeitos;'),
-- Capítulo 3
(12, 'SELECT f_origem.familiaFeudal AS origem, f_destino.familiaFeudal AS destino, t.recurso, t.data_transacao FROM transacoes_base t JOIN Feudo f_origem ON t.id_territorio_origem = f_origem.id JOIN Feudo f_destino ON t.id_territorio_destino = f_destino.id;'),
(13, 'SELECT * FROM Transacoes_Comerciais WHERE recurso = ''pedras flamejantes'';'),
(14, 'SELECT v.nome_artefato, f.familiaFeudal AS territorio_atual FROM posse_artefatos_base v JOIN Pessoa p ON v.id_personagem_portador = p.id JOIN Cidade c ON p.id = c.id_pessoa JOIN Feudo f ON c.id_feudo = f.id WHERE v.categoria = ''L'';'),
(15, 'SELECT p.nome AS nome_envolvido, p.sobreNome AS sobrenome_envolvido, m.recurso_principal AS mina_recurso FROM mineracao_base v JOIN Pessoa p ON v.id_pessoa = p.id JOIN Minas m ON v.id_mina = m.id WHERE m.recurso_principal = ''pedras flamejantes'';'),
(16, 'SELECT p_autorizador.nome AS senhor_autorizador, tc.recurso, a.data_ocorrido AS data_ataque FROM Transacoes_Comerciais tc JOIN Pessoa p_autorizador ON tc.id_senhor_autorizador = p_autorizador.id JOIN Ataques a ON tc.id_territorio_destino = a.id_territorio WHERE a.data_ocorrido > tc.data_transacao;'),
-- Capítulo 4
(17, 'SELECT ot.descricao_ordem, a.data_ocorrido AS data_ataque, a.nivel_impacto FROM ordens_torre_base ot JOIN Ataques a ON ot.id_territorio_alvo = a.id_territorio WHERE a.nivel_impacto > 8 AND ot.data_emissao < a.data_ocorrido;'),
(18, 'SELECT EXTRACT(YEAR FROM data_ocorrido) AS ano, AVG(quantidade_recursos) AS media_recursos FROM recursos_ataques_base GROUP BY ano;'),
(19, 'SELECT * FROM ataques_origem_recurso WHERE territorio_origem_recurso = ''Val’Nareth'';'),
(20, 'SELECT p1.nome AS senhor_da_torre, p2.nome AS aliado FROM Pessoa p1 JOIN Torres_Magicas tm ON p1.id = tm.id_senhor_da_torre JOIN aliancas_raw al ON p1.id = al.id_personagem1 JOIN Pessoa p2 ON al.id_personagem2 = p2.id WHERE tm.nome = ''Torre Mágica de Val’Nareth'';'),
(21, 'SELECT f.familiaFeudal AS territorio, COUNT(a.id) AS total_ataques FROM Ataques a JOIN Feudo f ON a.id_territorio = f.id WHERE a.data_ocorrido > ''535-01-01'' GROUP BY f.familiaFeudal ORDER BY total_ataques DESC;'),
-- Capítulo 5
(22, 'SELECT conteudo_hex FROM registros_hex_raw WHERE nome_torre = ''Torre Mágica de Val’Nareth'';'),
(23, 'SELECT ENCODE(DECODE(conteudo_hex, ''hex''), ''escape'') AS informacao_decodificada FROM registros_hex_raw WHERE nome_torre = ''Torre Mágica de Val’Nareth'';'),
(24, 'SELECT * FROM ordens_emitidas_raw WHERE id_emissor = (SELECT id FROM Pessoa WHERE nome = ''Líder dos Justiceiros'') AND conteudo_ordem LIKE ''%'' || (SELECT ENCODE(DECODE(conteudo_hex, ''hex''), ''escape'') FROM registros_hex_raw WHERE nome_torre = ''Torre Mágica de Val’Nareth'' LIMIT 1) || ''%'';'),
(25, 'SELECT nome_portador, sobrenome_portador FROM posse_artefato_personagem WHERE nome_artefato = ''Cajado do Coração de Fogo'';'),
(26, 'SELECT * FROM grimorio_final;');

-- Inserindo os Objetivos do Jogo
INSERT INTO Objetivo (id, descricao, nivel, solucaoInsert) VALUES
-- Capítulo 1
(1, 'Identificar todas as regiões e reinos do mundo mágico listados no banco de dados.', 0, 'SELECT nome_reino, geografia FROM regioes_reinos;'),
(2, 'Listar as espécies que governam cada território.', 0, 'SELECT especie_governante FROM especies_governantes;'),
(3, 'Encontrar o nome dos Senhores das Terras de cada território.', 0, 'SELECT nome_senhor, sobrenome_senhor, territorio_governado FROM senhores_das_terras;'),
(4, 'Verificar quais territórios possuem ligação com artefatos lendários.', 1, 'SELECT nome_artefato, territorio_localizacao FROM artefatos_por_territorio WHERE categoria = ''L'';'),
(5, 'Explorar as visões das tabelas de regiões para entender relações iniciais e interdependências.', 0, 'SELECT * FROM regioes_reinos; SELECT * FROM senhores_das_terras;'),
(6, 'Identificar o rei mais antigo ainda vivo, com a idade dele.', 1, 'SELECT nome, sobreNome, EXTRACT(YEAR FROM AGE(CURRENT_DATE, nascimento)) AS idade_atual FROM pessoas_vivas WHERE óbito IS NULL ORDER BY nascimento ASC LIMIT 1;'),
-- Capítulo 2
(7, 'Localizar todos os registros de ataques atribuídos aos Justiceiros.', 1, 'SELECT data_ocorrido, id_territorio FROM ataques_raw WHERE autor = ''Os Justiceiros'';'),
(8, 'Agrupar os ataques por território e contar a quantidade de ocorrências.', 2, 'SELECT territorio_atacado, COUNT(id) AS total_ataques FROM ataques_detalhe GROUP BY territorio_atacado;'),
(9, 'Filtrar os territórios com maior número de ataques.', 2, 'SELECT territorio_atacado, COUNT(id) AS total_ataques FROM ataques_detalhe GROUP BY territorio_atacado HAVING COUNT(id) > (SELECT AVG(contagem) FROM (SELECT COUNT(id) AS contagem FROM ataques_detalhe GROUP BY territorio_atacado) AS sub);'),
(10, 'Identificar se houve variação no número de ataques antes e depois do surgimento do grupo.', 2, 'WITH AtaquesPorAno AS (SELECT EXTRACT(YEAR FROM data_ocorrido) AS ano, COUNT(id) AS num_ataques FROM ataques_detalhe GROUP BY ano) SELECT ano, num_ataques, LAG(num_ataques, 1, 0) OVER (ORDER BY ano) AS ataques_ano_anterior, num_ataques - LAG(num_ataques, 1, 0) OVER (ORDER BY ano) AS variacao FROM AtaquesPorAno ORDER BY ano;'),
(11, 'Consultar visão protegida sobre vínculos suspeitos entre espécies e Justiceiros.', 1, 'SELECT * FROM vinculos_suspeitos;'),
-- Capítulo 3
(12, 'Cruzar dados de exportações e importações entre territórios para identificar rotas usadas pelos Justiceiros.', 3, 'SELECT f_origem.familiaFeudal AS origem, f_destino.familiaFeudal AS destino, t.recurso, t.data_transacao FROM transacoes_base t JOIN Feudo f_origem ON t.id_territorio_origem = f_origem.id JOIN Feudo f_destino ON t.id_territorio_destino = f_destino.id;'),
(13, 'Filtrar somente as transações que envolvem recursos usados em ataques (ex.: pedras flamejantes).', 3, 'SELECT * FROM Transacoes_Comerciais WHERE recurso = ''pedras flamejantes'';'),
(14, 'Localizar registros de troca de artefatos lendários entre territórios.', 3, 'SELECT v.nome_artefato, f.familiaFeudal AS territorio_atual FROM posse_artefatos_base v JOIN Pessoa p ON v.id_personagem_portador = p.id JOIN Cidade c ON p.id = c.id_pessoa JOIN Feudo f ON c.id_feudo = f.id WHERE v.categoria = ''L'';'),
(15, 'Listar todos os envolvidos com acesso a minas de pedras flamejantes.', 3, 'SELECT p.nome AS nome_envolvido, p.sobreNome AS sobrenome_envolvido, m.recurso_principal AS mina_recurso FROM mineracao_base v JOIN Pessoa p ON v.id_pessoa = p.id JOIN Minas m ON v.id_mina = m.id WHERE m.recurso_principal = ''pedras flamejantes'';'),
(16, 'Investigar transações comerciais autorizadas por Senhores das Terras e cruzar com ataques posteriores.', 3, 'SELECT p_autorizador.nome AS senhor_autorizador, tc.recurso, a.data_ocorrido AS data_ataque FROM Transacoes_Comerciais tc JOIN Pessoa p_autorizador ON tc.id_senhor_autorizador = p_autorizador.id JOIN Ataques a ON tc.id_territorio_destino = a.id_territorio WHERE a.data_ocorrido > tc.data_transacao;'),
-- Capítulo 4
(17, 'Relacionar ataques de maior impacto com ordens emitidas pela Torre Mágica.', 4, 'SELECT ot.descricao_ordem, a.data_ocorrido AS data_ataque, a.nivel_impacto FROM ordens_torre_base ot JOIN Ataques a ON ot.id_territorio_alvo = a.id_territorio WHERE a.nivel_impacto > 8 AND ot.data_emissao < a.data_ocorrido;'),
(18, 'Calcular a média de recursos usados em ataques por ano.', 2, 'SELECT EXTRACT(YEAR FROM data_ocorrido) AS ano, AVG(quantidade_recursos) AS media_recursos FROM recursos_ataques_base GROUP BY ano;'),
(19, 'Filtrar somente ataques onde a origem dos recursos seja o território de Val’Nareth.', 3, 'SELECT * FROM ataques_origem_recurso WHERE territorio_origem_recurso = ''Val’Nareth'';'),
(20, 'Identificar aliados políticos e militares do Senhor da Torre.', 4, 'SELECT p1.nome AS senhor_da_torre, p2.nome AS aliado FROM Pessoa p1 JOIN Torres_Magicas tm ON p1.id = tm.id_senhor_da_torre JOIN aliancas_raw al ON p1.id = al.id_personagem1 JOIN Pessoa p2 ON al.id_personagem2 = p2.id WHERE tm.nome = ''Torre Mágica de Val’Nareth'';'),
(21, 'Gerar ranking de territórios mais afetados desde o surgimento do Sem Nome.', 4, 'SELECT f.familiaFeudal AS territorio, COUNT(a.id) AS total_ataques FROM Ataques a JOIN Feudo f ON a.id_territorio = f.id WHERE a.data_ocorrido > ''535-01-01'' GROUP BY f.familiaFeudal ORDER BY total_ataques DESC;'),
-- Capítulo 5
(22, 'SELECT conteudo_hex FROM registros_hex_raw WHERE nome_torre = ''Torre Mágica de Val’Nareth'';'),
(23, 'SELECT ENCODE(DECODE(conteudo_hex, ''hex''), ''escape'') AS informacao_decodificada FROM registros_hex_raw WHERE nome_torre = ''Torre Mágica de Val’Nareth'';'),
(24, 'SELECT * FROM ordens_emitidas_raw WHERE id_emissor = (SELECT id FROM Pessoa WHERE nome = ''Líder dos Justiceiros'') AND conteudo_ordem LIKE ''%'' || (SELECT ENCODE(DECODE(conteudo_hex, ''hex''), ''escape'') FROM registros_hex_raw WHERE nome_torre = ''Torre Mágica de Val’Nareth'' LIMIT 1) || ''%'';'),
(25, 'SELECT nome_portador, sobrenome_portador FROM posse_artefato_personagem WHERE nome_artefato = ''Cajado do Coração de Fogo'';'),
(26, 'SELECT * FROM grimorio_final;');

-- Associando Visões aos Capítulos
INSERT INTO capitulo_visao (id, id_capitulo, id_visao) VALUES
-- Capítulo 1
(1, 1, 1), (2, 1, 2), (3, 1, 3), (4, 1, 4), (5, 1, 5),
-- Capítulo 2
(6, 2, 6), (7, 2, 7), (8, 2, 8),
-- Capítulo 3
(9, 3, 9), (10, 3, 10), (11, 3, 11),
-- Capítulo 4
(12, 4, 12), (13, 4, 13), (14, 4, 14), (15, 4, 15),
-- Capítulo 5
(16, 5, 16), (17, 5, 17), (18, 5, 18), (19, 5, 19);

-- Inserção/Atualização da tabela Objetivo com progressão técnica crescente e níveis de complexidade
-- Capítulo 1: O Básico (SELECT, DISTINCT, WHERE, ORDER BY, NULL)
INSERT INTO Objetivo (id, solucaoInsert, descricao, nivel) VALUES
(1, 'SELECT nome_reino, geografia FROM regioes_reinos;', 'Identificar todas as regiões e reinos do mundo mágico listados no banco de dados.', 0),
(2, 'SELECT DISTINCT especie_governante FROM especies_governantes;', 'Listar as espécies que governam cada território.', 0),
(3, 'SELECT nome_senhor, sobrenome_senhor FROM senhores_das_terras WHERE territorio_governado IS NOT NULL;', 'Encontrar o nome dos Senhores das Terras de cada território.', 1),
(4, 'SELECT nome_artefato FROM artefatos_por_territorio WHERE categoria = ''L'' ORDER BY nome_artefato ASC;', 'Verificar quais territórios possuem ligação com artefatos lendários.', 1),
(5, 'SELECT * FROM regioes_reinos WHERE geografia = ''N'' OR geografia = ''S'';', 'Explorar as visões das tabelas de regiões para entender relações iniciais e interdependências.', 1),
(6, 'SELECT nome, sobreNome FROM pessoas_vivas WHERE óbito IS NULL AND raça = ''Humano'';', 'Identificar o rei mais antigo ainda vivo, com a idade dele.', 1),
-- Capítulo 2: Agregações e Agrupamentos (COUNT, AVG, GROUP BY, HAVING)
(7, 'SELECT COUNT(*) FROM ataques_raw WHERE autor = ''Os Justiceiros'';', 'Localizar todos os registros de ataques atribuídos aos Justiceiros.', 2),
(8, 'SELECT territorio_atacado, COUNT(id) FROM ataques_detalhe GROUP BY territorio_atacado;', 'Agrupar os ataques por território e contar a quantidade de ocorrências.', 2),
(9, 'SELECT territorio_atacado FROM ataques_detalhe GROUP BY territorio_atacado HAVING COUNT(id) > 1;', 'Filtrar os territórios com maior número de ataques.', 2),
(10, 'SELECT AVG(quantidade_recursos) FROM ataques_raw;', 'Identificar se houve variação no número de ataques antes e depois do surgimento do grupo.', 2),
(11, 'SELECT * FROM vinculos_suspeitos WHERE nivel_perigo > (SELECT AVG(nivel_perigo) FROM vinculos_suspeitos);', 'Consultar visão protegida sobre vínculos suspeitos entre espécies e Justiceiros.', 4),
-- Capítulo 3: Relacionamentos e Junções (JOIN, INNER JOIN, ALIASES)
(12, 'SELECT T.recurso, F.familiaFeudal FROM transacoes_base T JOIN Feudo F ON T.id_territorio_origem = F.id;', 'Cruzar dados de exportações e importações entre territórios para identificar rotas usadas pelos Justiceiros.', 3),
(13, 'SELECT * FROM Transacoes_Comerciais WHERE recurso LIKE ''%flamejantes%'';', 'Filtrar somente as transações que envolvem recursos usados em ataques (ex.: pedras flamejantes).', 1),
(14, 'SELECT P.nome, A.nome FROM Pessoa P INNER JOIN Artefato A ON P.id = A.id_proprietário;', 'Localizar registros de troca de artefatos lendários entre territórios.', 3),
(15, 'SELECT P.nome, M.recurso_principal FROM Pessoa P JOIN Permissoes_Mineracao PM ON P.id = PM.id_pessoa JOIN Minas M ON PM.id_mina = M.id;', 'Listar todos os envolvidos com acesso a minas de pedras flamejantes.', 3),
(16, 'SELECT S.nome_senhor, T.recurso FROM senhores_das_terras S JOIN transacoes_base T ON S.id_territorio_governado = T.id_territorio_origem;', 'Investigar transações comerciais autorizadas por Senhores das Terras e cruzar com ataques posteriores.', 3),
-- Capítulo 4: Lógica Avançada (CASE, IN, BETWEEN, EXISTS)
(17, 'SELECT descricao_ordem, CASE WHEN nivel_impacto > 8 THEN ''Crítico'' ELSE ''Normal'' END AS status FROM ordens_torre_base;', 'Relacionar ataques de maior impacto com ordens emitidas pela Torre Mágica.', 4),
(18, 'SELECT * FROM ataques_raw WHERE data_ocorrido BETWEEN ''0539-01-01'' AND ''0539-12-31'';', 'Calcular a média de recursos usados em ataques por ano.', 1),
(19, 'SELECT * FROM ataques_origem_recurso WHERE territorio_origem_recurso IN (''Val’Nareth'', ''Cintra'');', 'Filtrar somente ataques onde a origem dos recursos seja o território de Val’Nareth.', 1),
(20, 'SELECT nome FROM Pessoa P WHERE EXISTS (SELECT 1 FROM Aliados_Politicos WHERE id_personagem1 = P.id);', 'Identificar aliados políticos e militares do Senhor da Torre.', 4),
(21, 'SELECT F.familiaFeudal, COUNT(A.id) FROM Feudo F LEFT JOIN Ataques A ON F.id = A.id_territorio GROUP BY F.familiaFeudal;', 'Gerar ranking de territórios mais afetados desde o surgimento do Sem Nome.', 3),
-- Capítulo 5: Decifração e Finalização (Hexadecimal, Decode, Funções de Sistema)
(22, 'SELECT conteudo_hex FROM registros_hex_raw WHERE nome_torre = ''Torre Mágica de Val’Nareth'';', 'SELECT conteudo_hex FROM registros_hex_raw WHERE nome_torre = ''Torre Mágica de Val’Nareth'';', 0),
(23, 'SELECT ENCODE(DECODE(conteudo_hex, ''hex''), ''escape'') FROM registros_hex_raw;', 'SELECT ENCODE(DECODE(conteudo_hex, ''hex''), ''escape'') AS informacao_decodificada FROM registros_hex_raw WHERE nome_torre = ''Torre Mágica de Val’Nareth'';', 4),
(24, 'SELECT * FROM ordens_emitidas_raw WHERE conteudo_ordem LIKE ''%torremago%'';', 'SELECT * FROM ordens_emitidas_raw WHERE id_emissor = (SELECT id FROM Pessoa WHERE nome = ''Líder dos Justiceiros'') AND conteudo_ordem LIKE ''%'' || (SELECT ENCODE(DECODE(conteudo_hex, ''hex''), ''escape'') FROM registros_hex_raw WHERE nome_torre = ''Torre Mágica de Val’Nareth'' LIMIT 1) || ''%'';', 1),
(25, 'SELECT P.nome FROM Pessoa P JOIN Artefato A ON P.id = A.id_proprietário WHERE A.nome = ''Cajado do Coração de Fogo'';', 'SELECT nome_portador, sobrenome_portador FROM posse_artefato_personagem WHERE nome_artefato = ''Cajado do Coração de Fogo'';', 3),
(26, 'SELECT * FROM grimorio_final;', 'SELECT * FROM grimorio_final;', 0);

-- Inserção das dicas na tabela 'dica', associadas aos Desafios (que correspondem aos Objetivos)
INSERT INTO dica (id_desafio, ordem, conteudo, penalidade_xp) VALUES
(1, 1, 'Comece pelo básico: use o comando SELECT para listar as colunas de identificação das regiões.', 0),
(2, 1, 'Existem muitas regiões, mas poucas raças soberanas. Use DISTINCT para listar as espécies sem repetições.', 0),
(3, 1, 'Filtre sua busca: use WHERE para encontrar apenas os senhores que possuem um território atribuído.', 0),
(4, 1, 'Organize suas provas: use ORDER BY para listar os artefatos lendários em ordem alfabética.', 0),
(5, 1, 'Amplie o filtro: use o operador OR para localizar reinos situados tanto no Norte quanto no Sul.', 0),
(6, 1, 'Refine com precisão: use AND e IS NULL para encontrar humanos que ainda caminham entre nós.', 0),
(7, 1, 'Quantifique a ameaça: use a função COUNT() para saber o total de ataques registrados pelo grupo.', 0),
(8, 1, 'Agrupe as evidências: use GROUP BY para contar os ataques separadamente por cada território.', 0),
(9, 1, 'Filtre grupos: use HAVING para identificar apenas as regiões que sofreram mais de um ataque.', 0),
(10, 1, 'Busque a média: use a função AVG() para entender o consumo médio de recursos nos atentados.', 0),
(11, 1, 'Subconsultas: compare o perigo de cada vínculo com a média global usando um SELECT dentro do outro.', 0),
(12, 1, 'Conecte tabelas: use JOIN e apelidos (Aliases) para relacionar transações aos nomes das famílias feudais.', 0),
(13, 1, 'Busca parcial: use o operador LIKE com curingas (%) para encontrar qualquer recurso que mencione chamas.', 0),
(14, 1, 'Junção interna: use INNER JOIN para listar apenas pessoas que efetivamente possuem um artefato.', 0),
(15, 1, 'Múltiplos relacionamentos: encadeie dois JOINs para ligar mineradores aos recursos que eles extraem.', 0),
(16, 1, 'Relacione autoridades: use JOIN para ver quais recursos estão saindo das terras de cada senhor.', 0),
(17, 1, 'Lógica condicional: use o comando CASE para rotular as ordens como Críticas ou Normais conforme o impacto.', 0),
(18, 1, 'Intervalos: use BETWEEN para encontrar todos os ataques ocorridos especificamente no ano de 539.', 0),
(19, 1, 'Múltiplas opções: use o operador IN para filtrar ataques cujos recursos vieram de Val’Nareth ou Cintra.', 0),
(20, 1, 'Verificação de existência: use EXISTS para listar apenas as pessoas que possuem aliados registrados.', 0),
(21, 1, 'Junção à esquerda: use LEFT JOIN para listar todos os feudos, inclusive aqueles que nunca foram atacados.', 0),
(22, 1, 'A chave está aqui: use um SELECT simples para extrair o código hexadecimal protegido na torre.', 0),
(23, 1, 'Tradução de dados: use as funções DECODE e ENCODE para transformar o hexadecimal em texto legível.', 0),
(24, 1, 'Busca de padrão: use LIKE para encontrar ordens que contenham a palavra-chave decifrada anteriormente.', 0),
(25, 1, 'O clímax: use JOIN para identificar quem é o atual e perigoso portador do lendário cajado.', 0),
(26, 1, 'A verdade final: execute um SELECT na visão final para ler o conteúdo do Grimório Primordial.', 0);

-- Os INSERTs para a tabela Desafio (id, nome, descricao, id_capitulo) permanecem os mesmos, pois não foram alterados na nova DDL.
-- Apenas para referência, o conteúdo original dos INSERTs de Desafio é:
-- INSERT INTO Desafio (id, nome, descricao, id_capitulo) VALUES
-- (1, 'MAPEANDO O MUNDO MÁGICO', 'O mundo mágico vive sob a sombra do preconceito e da desconfiança, um caos alimentado por lendas e guerras antigas. Como um investigador encarregado de restaurar a paz, sua primeira missão é obter um panorama completo da situação atual. É crucial mapear as diversas regiões, identificar as espécies que as governam e reconhecer os Senhores das Terras nomeados pela realeza. Fique atento também aos artefatos lendários, pois eles são o pivô de muitos conflitos históricos.', 1),
-- (2, 'PRIMEIRAS PISTAS DOS JUSTICEIROS', 'Um grupo extremista de bruxos, autointitulado "Os Justiceiros", está espalhando o terror com atentados brutais, como a explosão na Academia Mágica. Para combatê-los, é preciso primeiro entender seu modo de operação. Sua tarefa agora é mergulhar nos registros de ataques atribuídos ao grupo. Analise onde eles atacam, com que frequência e se há algum padrão em suas ações. Encontrar o epicentro de suas atividades é o primeiro passo para desvendar seus planos.', 2),
-- (3, 'TRAÇOS DE CONSPIRAÇÃO', 'Ataques dessa magnitude exigem planejamento, recursos e cúmplices. Os Justiceiros não poderiam agir sozinhos. Sua investigação agora deve focar nas conexões ocultas entre os territórios. Siga o rastro dos recursos, especialmente das "pedras flamejantes" usadas em seus explosivos. Investigue as transações comerciais, as rotas de suprimentos e quem autoriza essas movimentações. Uma aliança profana pode estar se escondendo por trás de acordos comerciais aparentemente legítimos.', 3),
-- (4, 'A MÁSCARA DO SEM NOME', 'As pistas sugerem que os Justiceiros são meros peões em um jogo muito maior. Há indícios de que um indivíduo extremamente poderoso e influente, um respeitado senhor da Torre Mágica de Val’Nareth, pode ser o verdadeiro cérebro por trás do caos. Conhecido apenas como "O Sem Nome" pelo medo que impõe, sua influência parece inquestionável. Sua missão é conectar as ordens emitidas por essa figura aos ataques dos Justiceiros, identificar seus aliados e expor a verdadeira hierarquia da conspiração.', 4),
-- (5, 'O HEXADECIMAL E O GRIMÓRIO', 'A investigação chegou ao seu clímax. Com a captura do líder dos Justiceiros, uma pista final e enigmática foi descoberta: um registro secreto, codificado em hexadecimal, localizado nos arquivos da Torre Mágica. Este código é a chave para a verdade final. Seu último desafio é encontrar este registro, decifrá-lo e usar a informação revelada para localizar o perdido Grimório Primordial. Apenas com ele em mãos, a história por trás de tudo será revelada e a paz poderá, finalmente, ser restaurada.', 5);
