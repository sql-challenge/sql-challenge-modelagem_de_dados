-- ============================================================
-- PATCH - Correções do banco do jogo
-- Aplicar APÓS o dml_gama.sql estar carregado.
-- Date: 2026-03-22
-- Execute conectado ao db_gestao com search_path apontando para magical_world.
-- ============================================================
SET search_path TO magical_world;


-- ============================================================
-- FIX 1: Artefato.categoria dos lendários
-- Problema: categoria='Leste' quebra todos os filtros WHERE categoria='L'
-- Impacto: Cap 1 Objetivo 4 retorna zero resultados
-- ============================================================
UPDATE Artefato SET categoria = 'L'
WHERE id IN (1000, 1001, 1002);


-- ============================================================
-- FIX 2: Cajado do Coração de Fogo — proprietário oficial
-- Problema: id_proprietário=101 (Líder) quando deveria ser 100 (O Sem Nome)
-- Motivo narrativo: O Sem Nome é o guardião oficial. A descoberta de que
-- o Líder dos Justiceiros está com o Cajado é a revelação do Cap 5.
-- A posse atual fica registrada em Posse_Artefatos (fix 3).
-- ============================================================
UPDATE Artefato SET id_proprietário = 100
WHERE id = 1000;


-- ============================================================
-- FIX 3: Posse_Artefatos — tabela estava completamente vazia
-- Problema: views posse_artefatos_base e posse_artefato_personagem
--           retornam zero resultados → Cap 5 Obj 4 quebrado
-- ============================================================
INSERT INTO Posse_Artefatos (id, id_artefato, id_personagem_portador, data_posse) VALUES
-- Cajado atualmente em posse do Líder dos Justiceiros (roubado/transferido)
(1, 1000, 101, '0539-11-01'),
-- Pedra Filosofal registrada com Rei Ferdinando desde sempre
(2, 1002, 102, '0001-01-01'),
-- Mapa Antigo com Senhor Elfo (aliado d''O Sem Nome)
(3, 1004, 104, '0400-01-01')
ON CONFLICT (id) DO UPDATE SET
  id_artefato = EXCLUDED.id_artefato,
  id_personagem_portador = EXCLUDED.id_personagem_portador,
  data_posse = EXCLUDED.data_posse;


-- ============================================================
-- FIX 4: Nomes com apóstrofe não-escapado (Val'Nareth → Val Nareth)
-- Problema A: apóstrofe literal causa erro de sintaxe SQL no INSERT original
-- Problema B: views e dicas usam 'Val Nareth' (sem apóstrofe) —
--             inconsistência impede que filtros WHERE nome = '...' funcionem
-- ============================================================

-- Feudo
UPDATE Feudo
SET familiaFeudal = 'Centauros de Val Nareth'
WHERE id = 1;

-- Torres Mágicas
UPDATE Torres_Magicas
SET nome = 'Torre Mágica de Val Nareth'
WHERE id = 1;

-- Cidade
UPDATE Cidade
SET nome = 'Val Nareth Capital'
WHERE id = 1;


-- ============================================================
-- FIX 5: vw_Pistas_Decifradas — tabela sem dados
-- Problema: Grimorio_Primordial.id_pista = 1001 mas não existe
--           linha correspondente em vw_Pistas_Decifradas
-- ============================================================
INSERT INTO vw_Pistas_Decifradas (id_pista, descricao) VALUES
(1001,
 'O Grimório Primordial encontra-se em Val Nareth. '
 'Decifre o registro hexadecimal da Torre Mágica e use '
 'a palavra-chave revelada para rastrear as ordens emitidas '
 'pelo Líder dos Justiceiros. O Cajado guiará o caminho final.');


-- ============================================================
-- VERIFICAÇÃO — queries para confirmar os fixes
-- ============================================================

-- Fix 1: deve retornar 3 lendários com categoria='L'
-- SELECT id, nome, categoria FROM Artefato WHERE categoria = 'L';

-- Fix 2: deve retornar O Sem Nome (id=100) como proprietário do Cajado
-- SELECT a.nome AS artefato, p.nome || ' ' || p.sobreNome AS proprietario
-- FROM Artefato a JOIN Pessoa p ON a.id_proprietário = p.id WHERE a.id = 1000;

-- Fix 3: deve retornar 3 linhas de posse
-- SELECT pa.id, a.nome AS artefato, p.nome || ' ' || p.sobreNome AS portador, pa.data_posse
-- FROM Posse_Artefatos pa
-- JOIN Artefato a ON pa.id_artefato = a.id
-- JOIN Pessoa p ON pa.id_personagem_portador = p.id;

-- Fix 4: deve retornar a torre com nome correto
-- SELECT id, nome FROM Torres_Magicas WHERE id = 1;

-- Fix 5: deve retornar a pista do grimório
-- SELECT * FROM vw_Pistas_Decifradas;

-- Fluxo Cap 5 completo:
-- SELECT conteudo_hex FROM registros_hex_raw WHERE nome_torre = 'Torre Mágica de Val Nareth';
-- SELECT ENCODE(DECODE('746f7272656d61676f56616c4e6172657468','hex'),'escape') AS palavra_chave;
-- SELECT * FROM ordens_emitidas_raw WHERE conteudo_ordem LIKE '%torremagoValNareth%';
-- SELECT nome_portador, sobrenome_portador FROM posse_artefato_personagem
--   WHERE nome_artefato = 'Cajado do Coração de Fogo';
-- SELECT * FROM grimorio_final;
