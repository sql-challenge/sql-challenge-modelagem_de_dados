**SQL Challenge - plataforma digital gamificada para o ensino da linguagem SQL.**

***Title: Título em Inglês***

> ***Abstract.** ~~You must follow the fields of the structured abstract, also kepping the subtitles in bold.~~ **Introduction**: A good abstract, in addition to succinctly informing the content of a scientific article, serves to attract attention to the work. However, in recent years, many articles submitted to SBGames do not present any type of standardization of abstracts, which also hinders the review process. **Objective**: Therefore, this year we will adopt a MANDATORY STRUCTURED ABSTRACT as a way to organize the work. **Methodology or Steps**: The organization of this structured abstract follows an adaptation of ABNT 6028:2021, which deals with standards for the presentation of abstracts. **Results**: Thus, it is expected that there will be an improvement in the presentation of abstracts and, consequently, in the quality of the articles. ATTENTION: In short papers, it should be changed to \"Expected Results\", since they mostly present research intentions and/or partial results.*
>
> ***Keywords:** Word 1, Word 2, Word 3, Word 4, Word 5.*
>
> ***Resumo.** ~~O resumo estruturado a seguir é obrigatório nos artigos, incluindo os campos em negrito devem pemanecer.~~ **Introdução**: Um bom resumo, além de informar sucintamente o conteúdo de um artigo científico, serve para atrair a atenção para o trabalho. Contudo, nos últimos anos, muitos artigos submetidos ao SBGames, não apresentam nenhum tipo de padronização dos resumos, o que, também dificulta o processo de revisão. **Objetivo**: Portanto, neste ano adotaremos o RESUMO ESTRUTURADO OBRIGATÓRIO, como forma de organizar os trabalho. **Metodologia ou Etapas**: A organização deste resumo estruturado segue uma adaptação da ABNT 6028:2021, que versa sobre normas para apresentação de resumos. **Resultados**: Assim espera-se que haja uma melhora na apresentação dos resumos e, consequentemente, na qualidade dos artigos. ATENÇÃO: Em trabalhos curtos, deve-se trocar para "Resultados Esperados", uma vez que eles apresentam na maioria das vezes, intenções de pesquisa e/ou resultados parciais.*
>
> ***Palavras-chave:** Palavra 1, Palavra 2, Palavra 3, Palavra 4, Palavra 5.*

**1. Introdução  
**Na contemporaneidade, a produção massiva e constante de dados, impulsionada pelo avanço das tecnologias digitais, têm demandado soluções eficientes para o armazenamento, organização e análise dessas informações. Esse fenômeno, frequentemente associado ao conceito de *Big Data*, tem transformado a forma como indivíduos, empresas e governos lidam com a informação (MAYER-SCHÖNBERGER; CUKIER, 2013). Nesse contexto, os Sistemas Gerenciadores de Banco de Dados (SGBDs) consolidaram-se como ferramentas essenciais para o gerenciamento estruturado de dados armazenados. Dentre diversos modelos existentes, os SGBDs relacionais destacam-se pela utilização de tabelas relacionadas, garantindo a integridade, consistência e escalabilidade das informações nele contidas.

De acordo com DB-ENGINES (2025), sete dos dez SGBDs mais utilizados no mundo em abril de 2025, são relacionais, incluindo nomes como Oracle, MySQL, PostgreSQL e SQL Server, que mantiveram suas posições também em meses anteriores, o que evidencia a forte presença e relevância desses sistemas no cenário tecnológico atual. Ademais, a utilidade e aplicabilidade dos SGBDs se expandem para diversos contextos, como o campo da ciência de dados, desenvolvimento web e mobile.

A habilidade de manipular e gerenciar dados nesses sistemas tornou-se, portanto, uma competência estratégica no cenário atual, principalmente para o processo de tomada de decisões nas organizações. Para tanto, é imprescindível o conhecimento e o correto uso da Structured Query language (SQL), que se configura como a linguagem padrão para gerenciamento e manipulação de dados em SGBDs relacionais e figura entre as habilidades técnicas mais requisitadas no mercado de trabalho. De acordo com levantamento realizado pela plataforma 365 Data Science (2024), a partir da análise de mil vagas de emprego para analistas de dados e cargos de desenvolvedores, 52,9% das ofertas mencionam o domínio de SQL como um requisito essencial. Corroborando essa tendência, o U.S. O Bureau of Labor Statistics (2022) projeta um crescimento de aproximadamente 9% na demanda anual por administradores de banco de dados (DBAs) no período de 2021 a 2031, evidenciando a crescente necessidade por profissionais qualificados na área.

Porém, alguns estudos como os de Poulsen e Migler (2020) demonstraram que os estudantes da área de tecnologia de informação tem dificuldade com os comandos da linguagem SQL, especialmente em consultas complexas que envolvem múltiplas junções entre tabelas, como subconsultas e outras operações. Diante disso, essa dificuldade é uma barreira no processo seletivo dos profissionais de computação. Na intenção de desvendar a fonte dessa dificuldade, pesquisa realizada por Morales-Trujillo e García-Mireles (2020), aponta que a escassez de plataformas acessíveis que permitam o desenvolvimento de consultas práticas é um obstáculo, pois os estudantes não têm acesso a exercícios de consultas práticas.

Neste contexto, a utilização de aplicações gamificadas e jogos sérios (*Serious Games*) torna-se uma possibilidade para auxiliar no aprendizado desses estudantes. A saber, jogos sérios representam uma modalidade que tem o propósito diferente do puro entretenimento, [sendo]{.mark} projetados com o objetivo na educação~~, em vez do entretenimento~~(CANALE, FARINETTI.2022). Essa modalidade é utilizada como ferramenta de simulação para formação profissional e finalidades educativas dentro da sala de aula (Fedwa Laamarti, 2014) e (Susi et al., 2007) para auxiliar no desenvolvimento do aprendizado.

Diante do cenário exposto, este estudo propõe o desenvolvimento de uma plataforma de estudos gamificada para o ensino de SQL, com foco no treinamento de consultas DQL (*Data Query Language*). A proposta é oferecer uma experiência de aprendizado mais dinâmica e envolvente, integrando elementos de gamificação que incentivem a prática de consultas complexas em um ambiente simulado.

**2. Trabalhos Relacionados**

Morales-Trujillo e García-Mireles (2020) implementaram uma tabela de rankings no *QueryCompetition* que promoveu um aumento significativo na motivação dos estudantes, gerando senso de realização pessoal e reconhecimento entre os pares. Para isso, eles propuseram um modelo de análise de desempenho que registra o tempo de resolução das tarefas durante a execução dos desafios, trazendo pesos e pontuações aplicados a níveis de dificuldade crescentes, nos quais os usuários resolvem consultas utilizando comandos limitados e progressivamente mais complexos. Essa segmentação proporcionou uma estrutura de aprendizado gradual, permitindo que os estudantes se familiarizassem com os conceitos básicos antes de enfrentar desafios mais avançados. Diante dessa aplicação, o *QueryCompetition*, proporcionou efeitos positivos nas avaliações pós-experimento com uma mediana duas vezes maior quando comparado com a turma que não utilizou a aplicação como pré-teste.

Canale e Farinetti (2023) demonstrou resultados positivos com a aplicação web *SQL Murder Mystery*, no qual desenvolveram inspirado na abordagem investigativa do jogo de tabuleiro Cluedo, onde os estudantes resolvem mistérios por meio de pistas espalhadas pelo banco de dados, e para isso utilizaram consultas para encontrá-las. De acordo com os autores, essa metodologia promove o pensamento crítico e o desenvolvimento de habilidades analíticas de forma lúdica, uma vez que os alunos precisam correlacionar dados, formular hipóteses e construir comandos DQL com precisão. Além disso, os autores tiverem a oportunidade de analisarar a sintaxe dos comandos realizados pelos estudantes, permitindo identificar padrões de erro, dificuldades específicas e *gaps* conceituais, tornando possível direcionar intervenções pedagógicas mais eficazes em sala de aula.

**3. Metodologia**

Informar a natureza da nossa pesquisa.

Este estudo adota o Design Science Research (DSR), processo metodológico descrito por Lacerda *et al.* (2013), que engloba etapas essenciais de Conscientização do Problema, Sugestão, Desenvolvimento, Avaliação e Conclusão​. Assim o DSR é um método robusto e interativo, voltado para o desenvolvimento e teste de artefatos tecnológicos inovadores, como uma ferramenta educacional. Diante disso, o presente estudo desenvolveu uma aplicação Web gamificada com o foco no nível procedimental da Taxonomia de Bloom onde foca na prática, assim alcançando a segunda etapa do DSR, logo a sugestão de um artefato. Diante disso, as etapas exigidas para o desenvolvimento da pesquisa foram:

1.  **Conscientização:** Inicialmente foi elaborada uma pesquisa bibliográfica levantando evidências que apontam o problema de pesquisa, conjuntamente com a identificação de métricas avaliativas.

2.  **Sugestão:** Diante das conclusões das pesquisas correlatas, foi elaborada a estrutura do artefato.

3.  **Desenvolvimento:** Escolha das tecnologias com a composição da ferramenta.

4.  **Avaliação:** Realizar os testes para averiguar a eficiência diante das métricas inicialmente definidas.

5.  **Conclusão:** Sintetizar os aprendizados e produzir a ~~documentação para o meio científico.~~

As etapas metodológicas alcançadas neste estudo foram a Conscientização e a Sugestão, alcançando parcialmente o Nível 2 da metodologia DSR.

**4. Aplicação PropostaJogo Proposto  
Nome da aplicação e o principal objetivo**

FUNCIONAMENTO BÁSICO DA APLICAÇÃO

À vista disso, a arquitetura pedagógica da aplicação SQL Challenge foi concebida com base na integração de três pilares principais: a implementação de *leaderboards*, a adoção de uma narrativa investigativa inspirada em Cluedo e a organização dos desafios por níveis. Integrando essas características sucedidas no trabalhos correlatos, a estrutura da plataforma tem o foco em construir diferentes histórias contendo mistérios a serem solucionados, sendo que cada história será segmentada em diferentes fases para resolver o mistério final, e para isso essas fases foram elaboradas de forma que respeita a complexidade sintática do nível. Sendo esses níveis separados com a seguinte forma:

**Tabela 2: Níveis de complexidade**

<table>
<colgroup>
<col style="width: 14%" />
<col style="width: 85%" />
</colgroup>
<thead>
<tr class="header">
<th><strong>Nível</strong></th>
<th><strong>Regra Sintática</strong></th>
</tr>
<tr class="odd">
<th>Level 0</th>
<th>Uso básico do SELECT para consultar colunas específicas de uma tabela. Ideal para visualizar informações iniciais e entender a estrutura dos dados.</th>
</tr>
<tr class="header">
<th>Level 1</th>
<th><p>Aplicação do SELECT com cláusula</p>
<p>WHERE para filtrar registros com base em uma condição. Útil para localizar dados específicos</p></th>
</tr>
<tr class="odd">
<th>Level 2</th>
<th>Uso de SELECT com GROUP BY e funções agregadas como COUNT para sumarizar dados e identificar padrões.</th>
</tr>
<tr class="header">
<th>Level 3</th>
<th>Combinação de SELECT com JOIN entre tabelas, permitindo cruzamento de informações para análises mais complexas.</th>
</tr>
<tr class="odd">
<th>Level 4</th>
<th>Uso avançado de SELECT com JOIN, subconsultas e funções agregadas. Explora múltiplos níveis de análise e cruzamento de dados.</th>
</tr>
</thead>
<tbody>
</tbody>
</table>

**Fonte: feita pelo autor**

Dessa forma, os estudantes terão a oportunidade de desenvolver habilidades gradualmente em um ambiente lúdico, inspirado em uma investigação nos moldes do jogo de tabuleiro Cluedo. Ao solucionarem as partes do mistério, será necessário o uso de comandos SQL conforme apresentado na tabela 2. Com isso, os estudantes poderão explorar o banco de dados por meio de diferentes métodos de consulta, compreendendo e avançando na história de forma paralela à complexidade das consultas exigidas, estimulando a prática e a capacidade analítica. De acordo com as pontuações obtidas pelos usuários ao solucionarem os níveis de cada etapa da história, serão atribuídas diferentes pontuações que alimentarão uma *leaderboard* com o *ranking* dos melhores 'solucionadores de mistérios'. Sendo as métricas avaliativas:

- **Tempo:** tempo com base na referência, a partir disso a pontuação será descontada proporcionalmente.

- **Quantidade de consultas:** após um número mínimo de tentativas, cada consulta extra reduz a pontuação.

- **Sintaxe da consulta:** Avalia a qualidade da instrução SQL utilizada: se usou o(s) comando(s) esperados, uma alternativa menos eficiente, ou não atingiu o objetivo.

Diante disso, as pontuações serão calculadas com base na referência de desempenho dos usuários gerais. Sendo a média das métricas como a média da nota em 50% da pontuação máxima. Dessa forma, será possível adaptar o valor da pontuação base de acordo com a dificuldade real observada na resolução do nível por parte dos participantes. O objetivo é garantir uma progressão justa e balanceada, ajustando o valor médio da pontuação final no ciclo, conforme a performance geral dos usuários naquele nível. Dessa forma pode garantir uma dinamicidade na distribuição da pontuação, levando em consideração os resultados dos estudantes que já solucionaram o mistério.

A partir desses conceitos apresentados, foi desenvolvido um protótipo inicial da plataforma *web* SQL Challenge, contendo histórias sugestivas de como seria a estrutura da aplicação. Assim, o usuário pode acessar e buscar a solução do mistério, assim como é mostrado nas imagens abaixo:

**Imagem 1.: Tela de apresentação da ferramenta**

![](media/image2.png){width="3.4744772528433945in" height="1.5957699037620297in"}

**Imagem 2: Tela para selecionar a história a ser solucionada**

![](media/image1.png){width="3.6156255468066494in" height="1.6356397637795275in"}

**5. Conclusões e Trabalhos Futurosão**

Este artigo apresentou o protótipo da aplicação web SQL Challenge, voltada ao aprendizado de SQL com elementos lúdicos e dinâmicos. Foram desenvolvidas a tela de apresentação e a navegação entre histórias, demonstrando o potencial do artefato como ferramenta educacional. A proposta busca tornar o processo de ensino mais atrativo e acessível, especialmente para iniciantes. Como trabalhos futuros, pretende-se finalizar as páginas de usuário, implementar o sistema de ranking com base em pontuação proporcional à complexidade das questões resolvidas, refinar a narrativa gamificada e realizar testes com usuários para avaliar usabilidade, engajamento e efetividade da aprendizagem. Espera-se, com isso, validar se os objetivos definidos foram alcançados e identificar possíveis melhorias no artefato.

**Referências**

[MAYER-SCHÖNBERGER, Viktor; CUKIER, Kenneth. Big data: como extrair volume, variedade, velocidade e valor da avalanche de informação cotidiana. Rio de Janeiro: Elsevier, 2013.]{.mark}

> [DB-ENGINES. DB-Engines Ranking - April 2025. Disponível em: <https://db-engines.com/en/ranking>. Acesso em: 17 abr. 2025.]{.mark}
>
> [365 DATA SCIENCE. SQL -- Still the Most In-Demand Skill for Data Analysts in 2024? 365 Data Science, 2024. Disponível em: <https://365datascience.com/trending/sql-still-the-most-in-demand-skill/>.]{.mark}
>
> [UNITED STATES. Bureau of Labor Statistics. Database Administrators and Architects. U.S. Bureau of Labor Statistics, 2022. Disponível em: <https://www.bls.gov/ooh/computer-and-information-technology/database-administrators.htm>.]{.mark}
