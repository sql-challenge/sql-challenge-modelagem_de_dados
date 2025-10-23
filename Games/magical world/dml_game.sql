-- Tabela Feudo (id, familiaFeudal, geografia)
INSERT INTO Feudo (id, familiaFeudal, geografia) VALUES
(1, 'Centauros de Val’Nareth', 'N'),
(2, 'Bruxos de Cintra', 'L'),
(3, 'Elfos das Florestas do Oeste', 'O'),
(4, 'Sereias do Marés de Coral', 'S'),
(5, 'Dragões das Cordilheiras', 'N'),
(6, 'Vampiros das Montanhas', 'S'),
(7, 'Fadas e Elfos do Oeste', 'O'),
(8, 'Realeza de Capital', 'C');

-- Tabela Pessoa 
INSERT INTO Pessoa (id, nome, sobreNome, raça, nascimento, óbito) VALUES
(100, 'O', 'Sem Nome', 'Centauro', '0100-01-01', NULL),
(101, 'Líder dos', 'Justiceiros', 'Bruxo', '0400-05-15', NULL),
(102, 'Ferdinando', 'I', 'Humano', '0001-01-01', NULL),
(103, 'Olivia', 'IV', 'Maga', '0200-03-20', '0450-10-10'),
(104, 'Senhor', 'Elfo', 'Elfo', '0350-07-07', NULL),
(105, 'Guardião', 'Chefe', 'Maga', '0400-01-01', NULL),
(106, 'Vítima', 'Explosão', 'Maga', '0450-01-01', '0539-11-01');

-- Tabela Artefato 
INSERT INTO Artefato (id, nome, categoria, quantidade, id_proprietário) VALUES
(1000, 'Cajado do Coração de Fogo', 'L', 1, 101),
(1001, 'Arca do Grimório Primordial', 'L', 1, NULL),
(1002, 'Pedra Filosofal', 'L', 1, 102),
(1003, 'Poção de Cura', 'C', 10, 105),
(1004, 'Mapa Antigo', 'C', 1, 104);

-- Tabela AcademiaMagica 
INSERT INTO AcademiaMagica (id, nome, qtd_matriculas, id_diretor) VALUES
(10, 'Academia Central de Magia', 500, 105);

-- Tabela Torres_Magicas (id, nome, id_territorio, id_senhor_da_torre)
INSERT INTO Torres_Magicas (id, nome, id_territorio, id_senhor_da_torre) VALUES
(1, 'Torre Mágica de Val’Nareth', 1, 100);

-- Tabela Cidade (id, nome, id_feudo, id_pessoa, id_academia)
INSERT INTO Cidade (id, nome, id_feudo, id_pessoa, id_academia) VALUES
(1, 'Val’Nareth Capital', 1, 100, NULL),
(2, 'Cintra Principal', 2, 101, NULL),
(3, 'Bosque Antigo', 3, 104, NULL),
(4, 'Capital Real', 8, 102, 10);

-- Tabela Minas 
INSERT INTO Minas (id, id_territorio, recurso_principal) VALUES
(1, 3, 'pedras flamejantes'),
(2, 5, 'minério de dragão'),
(3, 1, 'cristal mágico');

-- Tabela Permissoes_Mineracao 
INSERT INTO Permissoes_Mineracao (id, id_mina, id_pessoa) VALUES
(1, 1, 104),
(2, 1, 100),
(3, 2, 102);

-- Tabela Ataques
INSERT INTO Ataques (id, data_ocorrido, autor, id_territorio, nivel_impacto, recurso_principal_usado, quantidade_recursos) VALUES
(1, '0539-11-01', 'Os Justiceiros', 8, 10, 'pedras flamejantes', 137),
(2, '0539-12-05', 'Os Justiceiros', 4, 5, 'magia negra', 50),
(3, '0540-01-10', 'Os Justiceiros', 8, 8, 'pedras flamejantes', 80),
(4, '0540-02-20', 'Os Justiceiros', 5, 2, 'magia negra', 20),
(5, '0540-03-01', 'Os Justiceiros', 1, 1, 'magia negra', 10);

-- Tabela Transacoes_Comerciais 
INSERT INTO Transacoes_Comerciais (id, id_territorio_origem, id_territorio_destino, recurso, data_transacao, id_senhor_autorizador) VALUES
(1, 3, 2, 'pedras flamejantes', '0539-10-15', 104),
(2, 5, 8, 'minério de dragão', '0540-01-01', 102),
(3, 1, 8, 'cristal mágico', '0540-02-01', 100);

-- Tabela Ordens_Torre_Magica 
INSERT INTO Ordens_Torre_Magica (id_ordem, id_torre, data_emissao, id_territorio_alvo, descricao_ordem) VALUES
(1, 1, '0539-10-20', 8, 'Preparar o terreno para a "entrega" do recurso no centro.'),
(2, 1, '0540-01-05', 8, 'Reforçar a vigilância na Capital.'),
(3, 1, '0540-02-15', 5, 'Investigar a origem do minério de dragão.');

-- Tabela Ordens_Emitidas (id, id_emissor, conteudo_ordem)
INSERT INTO Ordens_Emitidas (id, id_emissor, conteudo_ordem) VALUES
(1, 101, 'Ordem de ataque contendo o atributo torremagoValNareth.'),
(2, 101, 'Ordem de recuo imediato.'),
(3, 100, 'Ordem de execução de traidores.');

-- Tabela Aliados_Politicos 
INSERT INTO Aliados_Politicos (id_alianca, id_personagem1, id_personagem2, data_inicio_alianca) VALUES
(1, 100, 104, '0539-09-01'),
(2, 102, 105, '0001-01-01');

-- Tabela Registros_Secretos 
INSERT INTO Registros_Secretos (id, id_torre, conteudo_hex) VALUES
(1, 1, '746f7272656d61676f56616c4e6172657468'); -- Hex de "torremagoValNareth"

-- Tabela Grimorio_Primordial (id_localizacao, conteudo, id_pista)
INSERT INTO Grimorio_Primordial (id_localizacao, conteudo, id_pista) VALUES
(1, 'O Grimório Primordial revela que a pandemia de fótons mágicos não foi um acidente, mas um ato deliberado dos próprios Arquimagos. Eles buscavam criar uma sociedade mágica mais resiliente, mas o experimento falhou, resultando na fragmentação das raças. O Sem Nome descobriu esta verdade e a usa para manipular os Justiceiros, prometendo restaurar a "pureza" mágica.', 1);

-- Tabela vw_Pistas_Decifradas (INSERT INTO vw_Pistas_Decifradas (id_pista, descricao) VALUES
(1, 'A pista final decodificada aponta para a Torre Mágica de Val’Nareth e o atributo chave "torremagoValNareth".');
