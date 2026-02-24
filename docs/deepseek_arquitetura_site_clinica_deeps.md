Para atender à sua solicitação, vou estruturar a análise como um **Guia Estratégico de Arquitetura da Informação e UX**, partindo da diferenciação dos modelos de negócio até a engenharia de conversão, tudo focado no contexto da Oncologia Ambulatorial.

A seguir, apresento a estratégia completa de pesquisa e estruturação para o site, em **Português do Brasil (PT-BR)** .

---

## Análise e Estratégia de Pesquisa para Arquitetura de Site: Cirurgia Oncológica Ambulatorial

### 1. Diferenciação do Modelo de Negócio: Clínica vs. Hospital

Antes de qualquer linha de código ou definição de menu, é crucial estabelecer a identidade digital baseada no modelo de atendimento.

*   **Se for uma Clínica Especializada:**
    *   **Foco:** Excelência técnica e agilidade. A comunicação deve destacar um ambiente de menor complexidade, mais privativo e com alta especialização. O tom é de "consultoria cirúrgica de alto padrão".
    *   **Narrativa:** "O melhor especialista, com o conforto e a rapidez de uma clínica dedicada."
    *   **Procedimentos Típicos:** Pequenas ressecções de lesões de pele (Câncer de Pele não melanoma), retirada de sinais, punções diagnósticas, e remoção de pequenos nódulos em regime ambulatorial.

*   **Se for um Hospital (com foco no ambulatório):**
    *   **Foco:** Estrutura e segurança integrada. O site deve segmentar claramente o "Ambulatório" ou "Centro Cirúrgico Ambulatorial" como uma porta de entrada distinta da internação.
    *   **Narrativa:** "A segurança do centro cirúrgico de um grande hospital, com a conveniência de ir para casa no mesmo dia."
    *   **Procedimentos Típicos:** Biópsias cirúrgicas profundas (mama, tireoide com sedação), implante e retirada de cateter totalmente implantável (Port-a-Cath), ressecções dermatológicas extensas que exigem anestesia, mas não internação.

---

### 2. Arquitetura da Informação (IA) e Mapeamento da Jornada do Paciente

A estrutura do site deve espelhar a jornada emocional e informacional do paciente oncológico. A ordem de pensamento geralmente é: `Sintoma/Diagnóstico` $\rightarrow$ `Procedimento Necessário` $\rightarrow$ `Médico/Trust` $\rightarrow$ `Logística/Pré-operatório`.

#### Estrutura de Menu Sugerida (Organização Híbrida: Procedimentos + Condições)

1.  **Procedimentos Ambulatoriais (Alta Intenção de Busca)**
    *   **Cirurgias de Pele e Partes Moles:** Ressecção de Câncer de Pele (Cirurgia Micrográfica de Mohs), Exérese de Nevos, Retirada de Lipomas.
    *   **Cirurgias de Mama (Ambulatoriais):** Nodulectomia, Setorectomia, Biópsia de Linfonodo Sentinela.
    *   **Acesso Venoso:** Implante de Cateter Totalmente Implantável (Port-a-Cath), Manutenção e Retirada de Cateter.
    *   **Diagnóstico por Imagem e Biópsias:** Biópsia de Tireoide (PAAF), Biópsia de Próstata, Core Biópsia de Mama.
    *   *Nota Técnica:* Cada um desses itens deve ser uma página individual, otimizada para SEO de cauda longa (ex: "como é feita a cirurgia de câncer de pele").

2.  **Corpo Clínico (O Fator Confiança)**
    *   Não é apenas um "quem somos". Cada cirurgião deve ter uma página individual detalhada.
    *   **Diferenciais:** Onde se formou, fellowships específicas em oncologia, áreas de atuação (ex: "Cirurgião especialista em Sarcoma", "Mastologista foco em cirurgia conservadora").
    *   **UX:** Incluir link direto para agendar com aquele profissional específico.

3.  **Guia do Paciente e Acompanhantes (Educação e Acolhimento)**
    *   **Pré-Operatório:** O que levar no dia? Jejum? Medicamentos? Exames recentes? (Checklist em PDF para download).
    *   **Pós-Operatório Ambulatorial:** Cuidados com a ferida operatória, sinais de alerta (febre, sangramento), repouso relativo, retorno para curativo. (Vídeos explicativos são excelentes aqui).
    *   **Dúvidas Frequentes sobre Cirurgia Oncológica:** Abordar mitos comuns.

4.  **Agendamento e Convênios**
    *   **Transparência:** Listar convênios atendidos.
    *   **Facilidade:** Formulário de contato específico para "Pré-Autorização" cirúrgica (ajuda o paciente com a burocracia do plano).
    *   **Botão WhatsApp:** Estratégico, visível em todas as páginas.

---

### 3. Engenharia de UX e Conversão (Foco no Paciente e Família)

A "conversão" aqui não é apenas uma venda, é um ato de confiança em um momento de vulnerabilidade.

#### a) Elementos de Confiança (Trust Signals)
*   **Certificações e Selos:** Selo da Sociedade Brasileira de Cirurgia Oncológica, Acreditações hospitalares (ONA, Qmentum). Posicionar no rodapé e nas páginas de procedimento.
*   **Testemunhos Estratégicos:** Não apenas "o médico é bom", mas relatos sobre o acolhimento. Ex: *"A enfermeira me explicou todo o passo a passo e isso acalmou minha ansiedade antes da biópsia."*
*   **Fotos Reais da Estrutura:** Mostrar a sala de espera (aconchegante), a sala de curativo, a sala de procedimento. Humanizar o ambiente tira o medo do "desconhecido".

#### b) Navegação por Jornada de Sintomas (Para quem ainda não tem diagnóstico)
*   **Cenário:** A pessoa sentiu um "caroço" ou tem uma "pinta suspeita".
*   **Solução UX:** Criar um caminho no site intitulado: **"Está com algum sintoma?"** ou **"Quando procurar um cirurgião oncológico?"**.
    *   *Fluxo:* "Nódulo na mama" $\rightarrow$ Página explicando possibilidades $\rightarrow$ Chamada para ação: "Agendar consulta de avaliação com mastologista".
    *   Isso captura o paciente no início da jornada, antes mesmo do diagnóstico fechado.

#### c) Estrutura Técnica (SEO e Performance)
*   **Schema Markup (Dados Estruturados):** Implementar `MedicalWebPage`, `Physician` e `HealthTopic` Schema. Isso ajuda o Google a entender que seu site é uma fonte confiável de saúde e melhora a aparência nos resultados de busca (rich snippets).
*   **Velocidade (Core Web Vitals):** Pacientes oncológicos e familiares frequentemente pesquisam em dispositivos móveis, muitas vezes em momentos de crise (emergência). O site precisa carregar em menos de 2.5 segundos.
*   **Conteúdo Evergreen:** Produzir conteúdo respondendo perguntas frequentes sobre os procedimentos listados no item 2.1. Vídeos curtos (1-2 minutos) do cirurgião explicando um procedimento específico aumentam drasticamente o tempo de permanência na página e a confiança.

#### d) Os 3 CTAs (Call to Action) Estratégicos
1.  **CCTA (Cadeia de Cuidados):** "Agende sua Consulta" (Botão principal, flutuante ou no topo).
2.  **CTI (Cadeia de Informação):** "Baixar Guia do Pré-Operatório" (Isca digital para captar leads qualificados e educar o paciente).
3.  **CTF (Cadeia de Familiar/Cuidador):** "Fale com a Enfermeira Navegadora" (Um contato humanizado via WhatsApp para tirar dúvidas logísticas e burocráticas, aliviando a ansiedade da família).

---

### 4. Estratégia de Pesquisa (Keywords e Intenção)

Para alimentar essa arquitetura, a pesquisa de palavras-chave deve focar na intenção do usuário:

*   **Intenção Transacional (Agendamento):**
    *   `cirurgião oncológico [cidade]`
    *   `implante de cateter port-a-cath [cidade]`
    *   `hospital para cirurgia de câncer de pele`
*   **Intenção Informacional (Educação):**
    *   `como é a recuperação de biópsia de mama`
    *   `dor após retirada de sinal`
    *   `cuidados com curativo cirúrgico`
    *   `biópsia de linfonodo dói?`
*   **Intenção Comercial (Comparação/Confiança):**
    *   `melhor cirurgião oncológico para tireoide`
    *   `hospital com centro ambulatorial para cirurgia`
    *   `avaliações cirurgião oncológico [nome]`

### Conclusão do Guia Estratégico

A estrutura de um site para cirurgia oncológica ambulatorial deve funcionar como um **acolhimento digital**. Ele precisa desmistificar o procedimento (camada educacional), validar a competência técnica da equipe (camada de autoridade) e oferecer caminhos fáceis e seguros para o próximo passo (camada de conversão).

A grande diferença entre um site comum e um de alta performance nesse setor está na capacidade de **reduzir a ansiedade** através da informação clara e de uma navegação que guia, em vez de confundir. A família que entende o processo é uma família que confia na instituição.