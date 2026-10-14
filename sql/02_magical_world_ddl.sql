SET client_encoding = 'UTF8';

CREATE SCHEMA IF NOT EXISTS magical_world;
SET search_path TO magical_world;

DROP TABLE IF EXISTS Pistas_Decifradas CASCADE;
DROP TABLE IF EXISTS Grimorio_Primordial CASCADE;
DROP TABLE IF EXISTS Posse_Artefatos CASCADE;
DROP TABLE IF EXISTS Ordens_Emitidas CASCADE;
DROP TABLE IF EXISTS Registros_Secretos CASCADE;
DROP TABLE IF EXISTS Aliados_Politicos CASCADE;
DROP TABLE IF EXISTS Ordens_Torre_Magica CASCADE;
DROP TABLE IF EXISTS Torres_Magicas CASCADE;
DROP TABLE IF EXISTS Permissoes_Mineracao CASCADE;
DROP TABLE IF EXISTS Minas CASCADE;
DROP TABLE IF EXISTS Transacoes_Comerciais CASCADE;
DROP TABLE IF EXISTS Ataques CASCADE;
DROP TABLE IF EXISTS Cidade CASCADE;
DROP TABLE IF EXISTS AcademiaMagica CASCADE;
DROP TABLE IF EXISTS Artefato CASCADE;
DROP TABLE IF EXISTS Pessoa CASCADE;
DROP TABLE IF EXISTS Feudo CASCADE;

CREATE TABLE Feudo (
    id BIGINT PRIMARY KEY,
    familiaFeudal VARCHAR(255) NOT NULL,
    geografia CHAR(1)
);

CREATE TABLE Pessoa (
    id BIGINT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    sobreNome VARCHAR(255),
    raça VARCHAR(255),
    nascimento DATE,
    óbito DATE
);

CREATE TABLE Artefato (
    id BIGINT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    categoria CHAR(1),
    id_proprietário BIGINT REFERENCES Pessoa(id)
);

CREATE TABLE AcademiaMagica (
    id BIGINT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    qtd_matriculas INT,
    id_diretor BIGINT REFERENCES Pessoa(id)
);

CREATE TABLE Cidade (
    id BIGINT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    id_feudo BIGINT REFERENCES Feudo(id),
    id_pessoa BIGINT REFERENCES Pessoa(id),
    id_academia BIGINT REFERENCES AcademiaMagica(id)
);

CREATE TABLE Ataques (
    id BIGINT PRIMARY KEY,
    data_ocorrido DATE NOT NULL,
    autor VARCHAR(255),
    id_territorio BIGINT REFERENCES Feudo(id),
    nivel_impacto INT,
    recurso_principal_usado VARCHAR(255),
    quantidade_recursos INT
);

CREATE TABLE Transacoes_Comerciais (
    id BIGINT PRIMARY KEY,
    id_territorio_origem BIGINT REFERENCES Feudo(id),
    id_territorio_destino BIGINT REFERENCES Feudo(id),
    recurso VARCHAR(255),
    data_transacao DATE,
    id_senhor_autorizador BIGINT REFERENCES Pessoa(id)
);

CREATE TABLE Minas (
    id BIGINT PRIMARY KEY,
    id_territorio BIGINT REFERENCES Feudo(id),
    recurso_principal VARCHAR(255)
);

CREATE TABLE Permissoes_Mineracao (
    id BIGINT PRIMARY KEY,
    id_mina BIGINT REFERENCES Minas(id),
    id_pessoa BIGINT REFERENCES Pessoa(id)
);

CREATE TABLE Torres_Magicas (
    id BIGINT PRIMARY KEY,
    nome VARCHAR(255),
    id_territorio BIGINT REFERENCES Feudo(id),
    id_senhor_da_torre BIGINT REFERENCES Pessoa(id)
);

CREATE TABLE Ordens_Torre_Magica (
    id_ordem BIGINT PRIMARY KEY,
    id_torre BIGINT REFERENCES Torres_Magicas(id),
    data_emissao DATE,
    id_territorio_alvo BIGINT REFERENCES Feudo(id),
    descricao_ordem TEXT
);

CREATE TABLE Aliados_Politicos (
    id_alianca BIGINT PRIMARY KEY,
    id_personagem1 BIGINT REFERENCES Pessoa(id),
    id_personagem2 BIGINT REFERENCES Pessoa(id),
    data_inicio_alianca DATE
);

CREATE TABLE Registros_Secretos (
    id BIGINT PRIMARY KEY,
    id_torre BIGINT REFERENCES Torres_Magicas(id),
    conteudo_hex TEXT
);

CREATE TABLE Ordens_Emitidas (
    id BIGINT PRIMARY KEY,
    id_emissor BIGINT REFERENCES Pessoa(id),
    conteudo_ordem TEXT
);

CREATE TABLE Posse_Artefatos (
    id BIGINT PRIMARY KEY,
    id_artefato BIGINT REFERENCES Artefato(id),
    id_personagem_portador BIGINT REFERENCES Pessoa(id),
    data_posse DATE
);

CREATE TABLE Grimorio_Primordial (
    id_localizacao BIGINT PRIMARY KEY,
    conteudo TEXT,
    id_pista BIGINT
);

CREATE TABLE Pistas_Decifradas (
    id_pista BIGINT PRIMARY KEY,
    descricao TEXT
);
