-- =====================================================================
-- CAPÍTULO 1: MAPEANDO O MUNDO MÁGICO [NÍVEL MÁXIMO: 1]
-- Foco: SELECT e WHERE (Level 0 e Level 1)
-- =====================================================================

-- Objetivo 1: Identificar todas as regiões e reinos do mundo mágico.
CREATE OR REPLACE VIEW regioes_reinos AS
SELECT familiaFeudal AS nome_reino, geografia
FROM Feudo;

-- Objetivo 2: Listar as espécies que governam cada território.
CREATE OR REPLACE VIEW especies_governantes AS
SELECT DISTINCT p.raça AS especie_governante
FROM Pessoa p
JOIN Cidade c ON p.id = c.id_pessoa;

-- Objetivo 3: Encontrar o nome dos Senhores das Terras de cada território.
CREATE OR REPLACE VIEW senhores_das_terras AS
SELECT p.nome AS nome_senhor, p.sobreNome AS sobrenome_senhor, f.familiaFeudal AS territorio_governado
FROM Pessoa p
JOIN Cidade c ON p.id = c.id_pessoa
JOIN Feudo f ON c.id_feudo = f.id;

-- Objetivo 4: Verificar quais territórios possuem ligação com artefatos lendários.
-- Objetivo 5: Explorar as visões das tabelas de regiões.
CREATE OR REPLACE VIEW artefatos_por_territorio AS
SELECT a.nome AS nome_artefato, a.categoria, f.familiaFeudal AS territorio_localizacao
FROM Artefato a
JOIN Pessoa p ON a.id_proprietário = p.id
JOIN Cidade c ON p.id = c.id_pessoa
JOIN Feudo f ON c.id_feudo = f.id;

-- Objetivo 6: Identificar o rei mais antigo ainda vivo.
CREATE OR REPLACE VIEW pessoas_vivas AS
SELECT nome, sobreNome, nascimento, óbito
FROM Pessoa;

-- =====================================================================
-- CAPÍTULO 2: PRIMEIRAS PISTAS DOS JUSTICEIROS [NÍVEL MÁXIMO: 2]
-- Foco: Level 2
-- =====================================================================

-- Objetivo 1: Localizar todos os registros de ataques atribuídos aos Justiceiros.
CREATE OR REPLACE VIEW ataques_raw AS
SELECT data_ocorrido, autor, id_territorio
FROM Ataques;

-- Objetivo 2, 3, 4: Agrupar e filtrar ataques por território/data.
CREATE OR REPLACE VIEW ataques_detalhe AS
SELECT
    a.id,
    a.data_ocorrido,
    f.familiaFeudal AS territorio_atacado
FROM Ataques a
JOIN Feudo f ON a.id_territorio = f.id
WHERE a.autor = 'Os Justiceiros'; 

-- Objetivo 5: Consultar visão protegida sobre vínculos suspeitos entre espécies e Justiceiros.
CREATE OR REPLACE VIEW vinculos_suspeitos AS
SELECT p.raça AS especie_associada, f.familiaFeudal AS territorio_associado
FROM Pessoa p
JOIN Cidade c ON p.id = c.id_pessoa
JOIN Feudo f ON c.id_feudo = f.id;

-- =====================================================================
-- CAPÍTULO 3: TRAÇOS DE CONSPIRAÇÃO [NÍVEL MÁXIMO: 3]
-- Foco: Level 3
-- =====================================================================

-- Objetivo 1, 2, 5: Transações comerciais.
CREATE OR REPLACE VIEW transacoes_base AS
SELECT
    id_territorio_origem,
    id_territorio_destino,
    recurso,
    data_transacao,
    id_senhor_autorizador
FROM Transacoes_Comerciais;

-- Objetivo 3: Troca de artefatos lendários.
CREATE OR REPLACE VIEW posse_artefatos_base AS
SELECT pa.id_artefato, pa.id_personagem_portador, pa.data_posse, a.nome AS nome_artefato, a.categoria
FROM Posse_Artefatos pa
JOIN Artefato a ON pa.id_artefato = a.id;

-- Objetivo 4: Envolvidos com acesso a minas de pedras flamejantes.
CREATE OR REPLACE VIEW mineracao_base AS
SELECT pm.id_mina, pm.id_pessoa, m.recurso_principal
FROM Permissoes_Mineracao pm
JOIN Minas m ON pm.id_mina = m.id;

-- =====================================================================
-- CAPÍTULO 4: A MÁSCARA DO SEM NOME [NÍVEL MÁXIMO: 4]
-- Foco: Level 4
-- =====================================================================

-- Objetivo 1: Relacionar ataques com ordens da Torre Mágica.
CREATE OR REPLACE VIEW ordens_torre_base AS
SELECT id_ordem, id_torre, data_emissao, id_territorio_alvo, descricao_ordem
FROM Ordens_Torre_Magica;

-- Objetivo 2, 5: Recursos usados em ataques e territórios afetados.
CREATE OR REPLACE VIEW recursos_ataques_base AS
SELECT data_ocorrido, id_territorio, quantidade_recursos
FROM Ataques;

-- Objetivo 3: Origem dos recursos de Val’Nareth.
CREATE OR REPLACE VIEW ataques_origem_recurso AS
SELECT a.data_ocorrido, a.recurso_principal_usado, f.familiaFeudal AS territorio_origem_recurso
FROM Ataques a
JOIN Feudo f ON a.id_territorio = f.id; -- Assumindo que id_territorio é o local do ataque, e o recurso vem de lá.

-- Objetivo 4: Aliados políticos e militares do Senhor da Torre.
CREATE OR REPLACE VIEW aliancas_raw AS
SELECT id_personagem1, id_personagem2
FROM Aliados_Politicos;

-- =====================================================================
-- CAPÍTULO 5: O HEXADECIMAL E O GRIMÓRIO [NÍVEL MÁXIMO: 4]
-- Foco: Level 4
-- =====================================================================

-- Objetivo 1, 2: Registros em hexadecimal ligados à Torre Mágica de Val’Nareth.
CREATE OR REPLACE VIEW registros_hex_raw AS
SELECT rs.conteudo_hex, tm.nome AS nome_torre
FROM Registros_Secretos rs
JOIN Torres_Magicas tm ON rs.id_torre = tm.id;

-- Objetivo 3: Ordens emitidas pelo líder dos Justiceiros.
-- O jogador deve usar Subconsulta e LIKE.
CREATE OR REPLACE VIEW ordens_emitidas_raw AS
SELECT id_emissor, conteudo_ordem
FROM Ordens_Emitidas;

-- Objetivo 4: Posse atual do Cajado do Coração de Fogo.
CREATE OR REPLACE VIEW posse_artefato_personagem AS
SELECT pa.id_artefato, p.nome AS nome_portador, p.sobreNome AS sobrenome_portador, a.nome AS nome_artefato
FROM Posse_Artefatos pa
JOIN Pessoa p ON pa.id_personagem_portador = p.id
JOIN Artefato a ON pa.id_artefato = a.id;

-- Objetivo 5: Revelar o conteúdo da visão final contendo o Grimório Primordial.
CREATE OR REPLACE VIEW grimorio_final AS
SELECT conteudo
FROM Grimorio_Primordial;
