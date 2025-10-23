-- Tabela Feudo
CREATE TABLE Feudo (
    id BIGINT PRIMARY KEY,
    familiaFeudal VARCHAR(255) NOT NULL,
    geografia CHAR(1)
);

-- Tabela Pessoa
CREATE TABLE Pessoa (
    id BIGINT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    sobreNome VARCHAR(255),
    raça VARCHAR(255),
    nascimento DATE,
    óbito DATE
);

-- Tabela Artefato
CREATE TABLE Artefato (
    id BIGINT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    categoria CHAR(1),
    id_proprietário BIGINT REFERENCES Pessoa(id)
);

-- Tabela AcademiaMagica
CREATE TABLE AcademiaMagica (
    id BIGINT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    qtd_matriculas INT,
    id_diretor BIGINT REFERENCES Pessoa(id)
);

-- Tabela Cidade 
CREATE TABLE Cidade (
    id BIGINT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    id_feudo BIGINT REFERENCES Feudo(id),
    id_pessoa BIGINT REFERENCES Pessoa(id),
    id_academia BIGINT REFERENCES AcademiaMagica(id)
);

-- Tabela para registrar os ataques
CREATE TABLE Ataques (
    id BIGINT PRIMARY KEY,
    data_ocorrido DATE NOT NULL,
    autor VARCHAR(255),
    id_territorio BIGINT REFERENCES Feudo(id),
    nivel_impacto INT,
    recurso_principal_usado VARCHAR(255),
    quantidade_recursos INT
);

-- Tabela para registrar transações comerciais entre territórios
CREATE TABLE Transacoes_Comerciais (
    id BIGINT PRIMARY KEY,
    id_territorio_origem BIGINT REFERENCES Feudo(id),
    id_territorio_destino BIGINT REFERENCES Feudo(id),
    recurso VARCHAR(255),
    data_transacao DATE,
    id_senhor_autorizador BIGINT REFERENCES Pessoa(id)
);

-- Tabela para as minas e seus recursos
CREATE TABLE Minas (
    id BIGINT PRIMARY KEY,
    id_territorio BIGINT REFERENCES Feudo(id),
    recurso_principal VARCHAR(255)
);

-- Tabela de permissões para mineração, ligando Pessoas a Minas
CREATE TABLE Permissoes_Mineracao (
    id BIGINT PRIMARY KEY,
    id_mina BIGINT REFERENCES Minas(id),
    id_pessoa BIGINT REFERENCES Pessoa(id)
);

-- Tabela para as torres mágicas, centros de poder
CREATE TABLE Torres_Magicas (
    id BIGINT PRIMARY KEY,
    nome VARCHAR(255),
    id_territorio BIGINT REFERENCES Feudo(id),
    id_senhor_da_torre BIGINT REFERENCES Pessoa(id)
);

-- Tabela para registrar ordens emitidas pelas torres
CREATE TABLE Ordens_Torre_Magica (
    id_ordem BIGINT PRIMARY KEY,
    id_torre BIGINT REFERENCES Torres_Magicas(id),
    data_emissao DATE,
    id_territorio_alvo BIGINT REFERENCES Feudo(id),
    descricao_ordem TEXT
);

-- Tabela para registrar alianças políticas entre personagens
CREATE TABLE Aliados_Politicos (
    id_alianca BIGINT PRIMARY KEY,
    id_personagem1 BIGINT REFERENCES Pessoa(id),
    id_personagem2 BIGINT REFERENCES Pessoa(id),
    data_inicio_alianca DATE
);

-- Tabela para os registros secretos em hexadecimal
CREATE TABLE Registros_Secretos (
    id BIGINT PRIMARY KEY,
    id_torre BIGINT REFERENCES Torres_Magicas(id),
    conteudo_hex TEXT
);

-- Tabela para ordens diretas emitidas por personagens
CREATE TABLE Ordens_Emitidas (
    id BIGINT PRIMARY KEY,
    id_emissor BIGINT REFERENCES Pessoa(id),
    conteudo_ordem TEXT
);

-- Tabela para rastrear a posse de artefatos
CREATE TABLE Posse_Artefatos (
    id BIGINT PRIMARY KEY,
    id_artefato BIGINT REFERENCES Artefato(id),
    id_personagem_portador BIGINT REFERENCES Pessoa(id),
    data_posse DATE
);

-- Tabela final que guarda a localização do Grimório
CREATE TABLE Grimorio_Primordial (
    id_localizacao BIGINT PRIMARY KEY,
    conteudo TEXT,
    id_pista BIGINT
);

-- Tabela para as 'visões' que o jogador pode consultar
CREATE TABLE vw_Pistas_Decifradas (
    id_pista BIGINT PRIMARY KEY,
    descricao TEXT
);