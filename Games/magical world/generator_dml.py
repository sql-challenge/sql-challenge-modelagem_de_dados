import random
from datetime import date, timedelta

# --- Dados Verdadeiros (Pistas) ---

# IDs base para evitar conflito com distratores (Distratores começarão em 300 para Feudo/Pessoa)
FEUDO_PISTAS = [
    (1, 'Centauros de Val’Nareth', 'N'),
    (2, 'Bruxos de Cintra', 'L'),
    (3, 'Elfos das Florestas do Oeste', 'O'),
    (4, 'Sereias do Marés de Coral', 'S'),
    (5, 'Dragões das Cordilheiras', 'N'),
    (6, 'Vampiros das Montanhas', 'S'),
    (7, 'Fadas e Elfos do Oeste', 'O'),
    (8, 'Realeza de Capital', 'C')
]
PESSOA_PISTAS = [
    (100, 'O', 'Sem Nome', 'Centauro', '0100-01-01', None), # Vilão principal
    (101, 'Líder dos', 'Justiceiros', 'Bruxo', '0400-05-15', None), # Preso
    (102, 'Ferdinando', 'I', 'Humano', '0001-01-01', None), # Rei Imortal 
    (103, 'Olivia', 'IV', 'Maga', '0200-03-20', '0450-10-10'), # Rainha Fundadora
    (104, 'Senhor', 'Elfo', 'Elfo', '0350-07-07', None), # Aliado
    (105, 'Guardião', 'Chefe', 'Maga', '0400-01-01', None), # Chefe da investigação
    (106, 'Vítima', 'Explosão', 'Maga', '0450-01-01', '0539-11-01') # Vítima
]
# Removida a coluna 'quantidade' (4º elemento) para Artefato
ARTEFATO_PISTAS = [
    (1000, 'Cajado do Coração de Fogo', 'L', 101), # Em posse do Líder dos Justiceiros
    (1001, 'Arca do Grimório Primordial', 'L', None),
    (1002, 'Pedra Filosofal', 'L', 102),
    (1003, 'Poção de Cura', 'C', 105),
    (1004, 'Mapa Antigo', 'C', 104)
]
ACADEMIA_PISTAS = [
    (10, 'Academia Central de Magia', 500, 105)
]
TORRES_PISTAS = [
    (1, 'Torre Mágica de Val’Nareth', 1, 100)
]
CIDADE_PISTAS = [
    (1, 'Val’Nareth Capital', 1, 100, None),
    (2, 'Cintra Principal', 2, 101, None),
    (3, 'Bosque Antigo', 3, 104, None),
    (4, 'Capital Real', 8, 102, 10)
]
MINAS_PISTAS = [
    (1, 3, 'pedras flamejantes'),
    (2, 5, 'minério de dragão'),
    (3, 1, 'cristal mágico')
]
PERMISSOES_PISTAS = [
    (1, 1, 104),
    (2, 1, 100),
    (3, 2, 102)
]
ATAQUES_PISTAS = [
    (1, '0539-11-01', 'Os Justiceiros', 8, 10, 'pedras flamejantes', 137),
    (2, '0539-12-05', 'Os Justiceiros', 4, 5, 'magia negra', 50),
    (3, '0540-01-10', 'Os Justiceiros', 8, 8, 'pedras flamejantes', 80),
    (4, '0540-02-20', 'Os Justiceiros', 5, 2, 'magia negra', 20),
    (5, '0540-03-01', 'Os Justiceiros', 1, 1, 'magia negra', 10)
]
TRANSACOES_PISTAS = [
    (1, 3, 2, 'pedras flamejantes', '0539-10-15', 104),
    (2, 5, 8, 'minério de dragão', '0540-01-01', 102),
    (3, 1, 8, 'cristal mágico', '0540-02-01', 100)
]
ORDENS_TORRE_PISTAS = [
    (1, 1, '0539-10-20', 8, 'Preparar o terreno para a "entrega" do recurso no centro.'),
    (2, 1, '0540-01-05', 8, 'Reforçar a vigilância na Capital.'),
    (3, 1, '0540-02-15', 5, 'Investigar a origem do minério de dragão.')
]
ORDENS_EMITIDAS_PISTAS = [
    (1, 101, 'Ordem de ataque contendo o atributo torremagoValNareth.'),
    (2, 101, 'Ordem de recuo imediato.'),
    (3, 100, 'Ordem de execução de traidores.')
]
ALIADOS_PISTAS = [
    (1, 100, 104, '0539-09-01'),
    (2, 102, 105, '0001-01-01')
]
REGISTROS_SECRETOS_PISTAS = [
    (1, 1, '746f7272656d61676f56616c4e6172657468')
]
GRIMORIO_PISTAS = [
    (1, 'O Grimório Primordial revela que a pandemia de fótons mágicos não foi um acidente, mas um ato deliberado dos próprios Arquimagos. Eles buscavam criar uma sociedade mágica mais resiliente, mas o experimento falhou, resultando na fragmentação das raças. O Sem Nome descobriu esta verdade e a usa para manipular os Justiceiros, prometendo restaurar a "pureza" mágica.', 1001)
]


# --- Funções Auxiliares para Geração de Dados ---

def get_random_date(start_year, end_year):
    start_date = date(start_year, 1, 1)
    end_date = date(end_year, 12, 31)
    time_between_dates = end_date - start_date
    days_between_dates = time_between_dates.days
    random_number_of_days = random.randrange(days_between_dates)
    random_date = start_date + timedelta(days=random_number_of_days)
    return random_date.strftime('%Y-%m-%d')

# Agora usa uma lista limitada de nomes de famílias/territórios coerentes
def generate_feudos(count):
    feudos = []
    # Nomes de famílias/territórios coerentes com a história (ex: Raças Dominantes/Clãs)
    nomes_familias = [
        "Clã do Vento", "Casa da Pedra", "Linha do Sol", "Povo das Sombras",
        "Reino do Gelo", "Guardiões da Floresta", "Nômades do Deserto", "Ordem da Magia Branca"
    ]
    geografias = ['N', 'S', 'L', 'O', 'C']
    start_id = 300 # Começa após os IDs de pista (1-8)

    for i in range(start_id, start_id + count):
        # O nome do feudo será o nome da família/território, sem o ID no final
        nome = random.choice(nomes_familias)
        geografia = random.choice(geografias)
        feudos.append((i, nome, geografia))
    return feudos

def generate_pessoas(count):
    pessoas = []
    nomes = ["Aeliana", "Bartholomew", "Caelen", "Dorian", "Elara", "Finnegan", "Giselle", "Horatio"]
    sobrenomes = ["Stone", "Flame", "Wind", "Shadow", "Light", "Iron", "Gold"]
    racas = ["Humano", "Elfo", "Bruxo", "Maga", "Gnomo", "Orc", "Sereia", "Vampiro", "Dragão"]
    start_id = 300 # Começa após os IDs de pista (100-106)

    for i in range(start_id, start_id + count):
        nome = random.choice(nomes)
        sobrenome = random.choice(sobrenomes)
        raca = random.choice(racas)
        nascimento = get_random_date(100, 500)
        obito = get_random_date(501, 540) if random.random() < 0.1 else None
        pessoas.append((i, nome, sobrenome, raca, nascimento, obito))
    return pessoas

# Removida a coluna 'quantidade'
def generate_artefatos(count, pessoa_ids):
    artefatos = []
    nomes = ["Amuleto", "Cajado", "Espada", "Livro", "Poção", "Anel", "Escudo"]
    categorias = ['L', 'C']
    start_id = 2000 # Começa após os IDs de pista (1000-1004)

    for i in range(start_id, start_id + count):
        nome = random.choice(nomes) + " " + str(i)
        categoria = random.choice(categorias)
        proprietario = random.choice(pessoa_ids) if pessoa_ids else None
        artefatos.append((i, nome, categoria, proprietario)) # 4 elementos
    return artefatos

def generate_academias(count, pessoa_ids):
    academias = []
    nomes = ["Academia de Magia", "Instituto de Feitiçaria", "Escola Arcana", "Universidade Mágica"]
    start_id = 100 # Começa após o ID de pista (10)

    for i in range(start_id, start_id + count):
        nome = random.choice(nomes) + " " + str(i)
        qtd_matriculas = random.randint(50, 500)
        diretor = random.choice(pessoa_ids)
        academias.append((i, nome, qtd_matriculas, diretor))
    return academias

def generate_torres(count, feudo_ids, pessoa_ids):
    torres = []
    nomes = ["Torre de Vigia", "Fortaleza Mágica", "Posto Avançado", "Torre do Conhecimento"]
    start_id = 100 # Começa após o ID de pista (1)

    for i in range(start_id, start_id + count):
        nome = random.choice(nomes) + " " + str(i)
        territorio = random.choice(feudo_ids)
        senhor = random.choice(pessoa_ids)
        torres.append((i, nome, territorio, senhor))
    return torres

def generate_cidades(count, feudo_ids, pessoa_ids, academia_ids):
    cidades = []
    nomes = ["Porto", "Vila", "Capital", "Posto"]
    start_id = 100 # Começa após os IDs de pista (1-4)

    for i in range(start_id, start_id + count):
        nome = random.choice(nomes) + " " + str(i)
        feudo = random.choice(feudo_ids)
        pessoa = random.choice(pessoa_ids)
        academia = random.choice(academia_ids) if random.random() < 0.2 else None
        cidades.append((i, nome, feudo, pessoa, academia))
    return cidades

def generate_minas(count, feudo_ids):
    minas = []
    recursos = ["ouro", "prata", "ferro", "carvão", "gás mágico", "pedras preciosas"]
    start_id = 100 # Começa após os IDs de pista (1-3)

    for i in range(start_id, start_id + count):
        territorio = random.choice(feudo_ids)
        recurso = random.choice(recursos)
        minas.append((i, territorio, recurso))
    return minas

def generate_permissoes(count, mina_ids, pessoa_ids):
    permissoes = []
    start_id = 100 # Começa após os IDs de pista (1-3)

    # Para evitar duplicatas, usamos um set
    unique_permissoes = set()
    while len(unique_permissoes) < count:
        mina = random.choice(mina_ids)
        pessoa = random.choice(pessoa_ids)
        unique_permissoes.add(tuple(sorted((mina, pessoa))))

    for i, (mina, pessoa) in enumerate(unique_permissoes):
        permissoes.append((start_id + i, mina, pessoa))
    return permissoes

def generate_ataques(count, feudo_ids):
    ataques = []
    autores = ["Bandidos da Estrada", "Rebeldes do Sul", "Mercenários", "Criaturas Selvagens"]
    recursos = ["espadas", "flechas", "magia de fogo", "veneno"]
    start_id = 100 # Começa após os IDs de pista (1-5)

    for i in range(start_id, start_id + count):
        data = get_random_date(500, 540)
        autor = random.choice(autores)
        territorio = random.choice(feudo_ids)
        impacto = random.randint(1, 7)
        recurso = random.choice(recursos)
        quantidade = random.randint(10, 100)
        ataques.append((i, data, autor, territorio, impacto, recurso, quantidade))
    return ataques

# Ajustado para as colunas do DDL (id_territorio_origem, id_territorio_destino, id_senhor_autorizador)
def generate_transacoes(count, feudo_ids, pessoa_ids):
    transacoes = []
    recursos = ["trigo", "madeira", "ouro", "especiarias"]
    start_id = 100 # Começa após os IDs de pista (1-3)

    for i in range(start_id, start_id + count):
        origem = random.choice(feudo_ids)
        destino = random.choice(feudo_ids)
        while origem == destino:
            destino = random.choice(feudo_ids)
        recurso = random.choice(recursos)
        data = get_random_date(500, 540)
        autorizador = random.choice(pessoa_ids)
        transacoes.append((i, origem, destino, recurso, data, autorizador))
    return transacoes

# Ajustado para as colunas do DDL (id_ordem, id_torre, id_territorio_alvo, descricao_ordem)
def generate_ordens_torre(count, torre_ids, feudo_ids):
    ordens = []
    descricoes = ["Ordem de Patrulha", "Ordem de Coleta de Impostos", "Ordem de Construção", "Ordem de Treinamento"]
    start_id = 100 # Começa após os IDs de pista (1-3)

    for i in range(start_id, start_id + count):
        torre = random.choice(torre_ids)
        data = get_random_date(500, 540)
        alvo = random.choice(feudo_ids)
        descricao = random.choice(descricoes) + " " + str(i)
        ordens.append((i, torre, data, alvo, descricao))
    return ordens

# Ajustado para a coluna do DDL (conteudo_ordem)
def generate_ordens_emitidas(count, pessoa_ids):
    ordens = []
    descricoes = ["Recrutamento", "Missão de Espionagem", "Entrega de Mensagem", "Reunião Secreta"]
    start_id = 100 # Começa após os IDs de pista (1-3)

    for i in range(start_id, start_id + count):
        emissor = random.choice(pessoa_ids)
        conteudo = random.choice(descricoes) + " " + str(i)
        ordens.append((i, emissor, conteudo))
    return ordens

# Ajustado para as colunas do DDL (id_alianca, id_personagem1, id_personagem2, data_inicio_alianca)
def generate_aliados(count, pessoa_ids):
    aliados = []
    start_id = 100 # Começa após os IDs de pista (1-2)

    # Para evitar duplicatas e auto-alianças
    unique_aliados = set()
    while len(unique_aliados) < count:
        p1 = random.choice(pessoa_ids)
        p2 = random.choice(pessoa_ids)
        if p1 != p2:
            # Normalizar a tupla para garantir unicidade
            unique_aliados.add(tuple(sorted((p1, p2))))

    for i, (p1, p2) in enumerate(unique_aliados):
        data = get_random_date(500, 540)
        aliados.append((start_id + i, p1, p2, data))
    return aliados

# --- Função Principal de Geração ---

def generate_all_inserts(target_count=200):
    sql_script = []
    
    # 1. Coleta de IDs de Pista
    feudo_ids_pista = [f[0] for f in FEUDO_PISTAS]
    pessoa_ids_pista = [p[0] for p in PESSOA_PISTAS]
    # Artefato agora tem 4 elementos
    artefato_ids_pista = [a[0] for a in ARTEFATO_PISTAS]
    academia_ids_pista = [a[0] for a in ACADEMIA_PISTAS]
    torre_ids_pista = [t[0] for t in TORRES_PISTAS]
    mina_ids_pista = [m[0] for m in MINAS_PISTAS]

    # 2. Geração de Distratores
    # A função generate_feudos agora gera nomes de famílias coerentes
    feudos_distratores = generate_feudos(target_count - len(feudo_ids_pista))
    pessoas_distratores = generate_pessoas(target_count - len(pessoa_ids_pista))
    
    # IDs Totais após Feudos e Pessoas
    feudo_ids_total = feudo_ids_pista + [f[0] for f in feudos_distratores]
    pessoa_ids_total = pessoa_ids_pista + [p[0] for p in pessoas_distratores]

    artefatos_distratores = generate_artefatos(target_count - len(ARTEFATO_PISTAS), pessoa_ids_total)
    academias_distratores = generate_academias(target_count - len(ACADEMIA_PISTAS), pessoa_ids_total)
    torres_distratores = generate_torres(target_count - len(TORRES_PISTAS), feudo_ids_total, pessoa_ids_total)
    
    # IDs Totais (Pistas + Distratores)
    artefato_ids_total = artefato_ids_pista + [a[0] for a in artefatos_distratores]
    academia_ids_total = academia_ids_pista + [a[0] for a in academias_distratores]
    torre_ids_total = torre_ids_pista + [t[0] for t in torres_distratores]
    
    # Geração de tabelas de relacionamento e eventos (usando IDs totais)
    cidades_distratores = generate_cidades(target_count - len(CIDADE_PISTAS), feudo_ids_total, pessoa_ids_total, academia_ids_total)
    minas_distratores = generate_minas(target_count - len(MINAS_PISTAS), feudo_ids_total)
    mina_ids_total = mina_ids_pista + [m[0] for m in minas_distratores]

    permissoes_distratores = generate_permissoes(target_count - len(PERMISSOES_PISTAS), mina_ids_total, pessoa_ids_total)
    ataques_distratores = generate_ataques(target_count - len(ATAQUES_PISTAS), feudo_ids_total)
    transacoes_distratores = generate_transacoes(target_count - len(TRANSACOES_PISTAS), feudo_ids_total, pessoa_ids_total)
    ordens_torre_distratores = generate_ordens_torre(target_count - len(ORDENS_TORRE_PISTAS), torre_ids_total, feudo_ids_total)
    ordens_emitidas_distratores = generate_ordens_emitidas(target_count - len(ORDENS_EMITIDAS_PISTAS), pessoa_ids_total)
    aliados_distratores = generate_aliados(target_count - len(ALIADOS_PISTAS), pessoa_ids_total)


    # 3. Função para formatar INSERT
    def format_insert(table_name, columns, data_list):
        if not data_list:
            return ""
        
        columns_str = ", ".join(columns)
        values_str = []
        for row in data_list:
            formatted_row = []
            for item in row:
                if item is None:
                    formatted_row.append("NULL")
                elif isinstance(item, str):
                    # Escapar aspas simples para SQL
                    escaped_item = item.replace("'", "''")
                    formatted_row.append(f"'{escaped_item}'")
                else:
                    formatted_row.append(str(item))
            values_str.append(f"({', '.join(formatted_row)})")
        
        return f"-- Tabela {table_name} (Total: {len(data_list)})\nINSERT INTO {table_name} ({columns_str}) VALUES\n" + ",\n".join(values_str) + ";\n\n"

    # 4. Geração do Script

    # FASE 1: PISTAS
    sql_script.append("-- -----------------------------------------------------------------------------\n-- FASE 1: PISTAS (Dados cruciais para a investigação - Compatível com DDL)\n-- -----------------------------------------------------------------------------\n\n")

    sql_script.append(format_insert("Feudo", ["id", "familiaFeudal", "geografia"], FEUDO_PISTAS))
    sql_script.append(format_insert("Pessoa", ["id", "nome", "sobreNome", "raça", "nascimento", "óbito"], PESSOA_PISTAS))
    # Removida a coluna 'quantidade'
    sql_script.append(format_insert("Artefato", ["id", "nome", "categoria", "id_proprietário"], ARTEFATO_PISTAS))
    sql_script.append(format_insert("AcademiaMagica", ["id", "nome", "qtd_matriculas", "id_diretor"], ACADEMIA_PISTAS))
    sql_script.append(format_insert("Torres_Magicas", ["id", "nome", "id_territorio", "id_senhor_da_torre"], TORRES_PISTAS))
    sql_script.append(format_insert("Cidade", ["id", "nome", "id_feudo", "id_pessoa", "id_academia"], CIDADE_PISTAS))
    sql_script.append(format_insert("Minas", ["id", "id_territorio", "recurso_principal"], MINAS_PISTAS))
    sql_script.append(format_insert("Permissoes_Mineracao", ["id", "id_mina", "id_pessoa"], PERMISSOES_PISTAS))
    sql_script.append(format_insert("Ataques", ["id", "data_ocorrido", "autor", "id_territorio", "nivel_impacto", "recurso_principal_usado", "quantidade_recursos"], ATAQUES_PISTAS))
    sql_script.append(format_insert("Transacoes_Comerciais", ["id", "id_territorio_origem", "id_territorio_destino", "recurso", "data_transacao", "id_senhor_autorizador"], TRANSACOES_PISTAS))
    sql_script.append(format_insert("Ordens_Torre_Magica", ["id_ordem", "id_torre", "data_emissao", "id_territorio_alvo", "descricao_ordem"], ORDENS_TORRE_PISTAS))
    sql_script.append(format_insert("Ordens_Emitidas", ["id", "id_emissor", "conteudo_ordem"], ORDENS_EMITIDAS_PISTAS))
    sql_script.append(format_insert("Aliados_Politicos", ["id_alianca", "id_personagem1", "id_personagem2", "data_inicio_alianca"], ALIADOS_PISTAS))
    sql_script.append(format_insert("Registros_Secretos", ["id", "id_torre", "conteudo_hex"], REGISTROS_SECRETOS_PISTAS))
    sql_script.append(format_insert("Grimorio_Primordial", ["id_localizacao", "conteudo", "id_pista"], GRIMORIO_PISTAS))


    # FASE 2: BASES (DISTRATORES)
    sql_script.append("-- -----------------------------------------------------------------------------\n-- FASE 2: TABELAS BASE (DISTRATORES - Coerente com a História)\n-- -----------------------------------------------------------------------------\n\n")

    sql_script.append(format_insert("Feudo", ["id", "familiaFeudal", "geografia"], feudos_distratores))
    sql_script.append(format_insert("Pessoa", ["id", "nome", "sobreNome", "raça", "nascimento", "óbito"], pessoas_distratores))
    sql_script.append(format_insert("Artefato", ["id", "nome", "categoria", "id_proprietário"], artefatos_distratores))
    sql_script.append(format_insert("AcademiaMagica", ["id", "nome", "qtd_matriculas", "id_diretor"], academias_distratores))
    sql_script.append(format_insert("Torres_Magicas", ["id", "nome", "id_territorio", "id_senhor_da_torre"], torres_distratores))

    # FASE 3: RELACIONAMENTOS E EVENTOS (DISTRATORES)
    sql_script.append("-- -----------------------------------------------------------------------------\n-- FASE 3: RELACIONAMENTOS E EVENTOS (DISTRATORES - Coerente com a História)\n-- -----------------------------------------------------------------------------\n\n")

    sql_script.append(format_insert("Cidade", ["id", "nome", "id_feudo", "id_pessoa", "id_academia"], cidades_distratores))
    sql_script.append(format_insert("Minas", ["id", "id_territorio", "recurso_principal"], minas_distratores))
    sql_script.append(format_insert("Permissoes_Mineracao", ["id", "id_mina", "id_pessoa"], permissoes_distratores))
    sql_script.append(format_insert("Ataques", ["id", "data_ocorrido", "autor", "id_territorio", "nivel_impacto", "recurso_principal_usado", "quantidade_recursos"], ataques_distratores))
    sql_script.append(format_insert("Transacoes_Comerciais", ["id", "id_territorio_origem", "id_territorio_destino", "recurso", "data_transacao", "id_senhor_autorizador"], transacoes_distratores))
    sql_script.append(format_insert("Ordens_Torre_Magica", ["id_ordem", "id_torre", "data_emissao", "id_territorio_alvo", "descricao_ordem"], ordens_torre_distratores))
    sql_script.append(format_insert("Ordens_Emitidas", ["id", "id_emissor", "conteudo_ordem"], ordens_emitidas_distratores))
    sql_script.append(format_insert("Aliados_Politicos", ["id_alianca", "id_personagem1", "id_personagem2", "data_inicio_alianca"], aliados_distratores))
    
    return "\n".join(sql_script)

if __name__ == "__main__":

    TARGET_COUNT = 1000
    
    print(f"Gerando script SQL com {TARGET_COUNT} registros por tabela...")
    
    sql_content = generate_all_inserts(TARGET_COUNT)
    
    output_file = "generated_data_v3.sql"
    with open(output_file, "w", encoding="utf-8") as f:
        f.write(sql_content)
        
    print(f"Script SQL gerado com sucesso em '{output_file}'")
    print("Total de linhas geradas: " + str(len(sql_content.splitlines())))
