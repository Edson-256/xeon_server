# **Arquitetura Estratégica e Engenharia de Experiência do Usuário para Portais de Oncologia Cirúrgica: Um Guia de Práticas Avançadas**

A construção de um ecossistema digital para instituições de oncologia cirúrgica exige uma compreensão profunda da dualidade emocional enfrentada pelo usuário: a urgência por informações técnicas precisas e a necessidade de acolhimento em um momento de fragilidade extrema. Como Senior Web Architect e UX Specialist, a análise aqui apresentada fundamenta-se na premissa de que o site de uma clínica ou hospital oncológico não é apenas uma ferramenta de marketing, mas uma extensão do cuidado assistencial. No Brasil, o cenário é moldado por instituições de excelência que elevam o padrão de atendimento, como o Hospital Israelita Albert Einstein, o A.C.Camargo Cancer Center e o Grupo Oncoclínicas, cujas presenças digitais servem como benchmarking para a arquitetura de informação e a jornada do paciente.1

A estratégia de pesquisa para a estruturação desses sites deve contemplar a distinção clara entre os modelos de negócio e a natureza dos procedimentos oferecidos. Quando o foco recai sobre clínicas especializadas, a agilidade do atendimento ambulatorial e a personalização da experiência são os pilares centrais. Em contrapartida, para grandes hospitais, o desafio reside em isolar a jornada de serviços ambulatoriais e procedimentos menores — como biópsias, ressecções de lesões de pele e implantes de cateteres totalmente implantáveis (chemo ports) — da complexidade inerente ao atendimento de alta complexidade e internação, garantindo que o paciente de "pequenas cirurgias" não se sinta perdido em um ambiente burocrático ou intimidante.4

## **Distinção de Modelos: Clínica Ágil vs. Bloco Ambulatorial Hospitalar**

A arquitetura de informação (IA) deve refletir o modelo operacional da instituição para alinhar as expectativas do paciente desde o primeiro clique. A clínica oncológica, focada no regime ambulatorial, opera sob a lógica da conveniência e da rapidez. O site de uma clínica deve ser projetado para reduzir o tempo entre a dúvida do paciente e o agendamento do procedimento, utilizando uma navegação direta e simplificada. Já no ambiente hospitalar, a estratégia mais eficaz tem sido a criação de centros de referência ou blocos exclusivos para oncologia, localizados muitas vezes fora do prédio principal de internação, o que permite uma jornada mais fluida e humanizada.4

### **A Clínica de Cirurgia Oncológica Ambulatorial**

Neste modelo, o design deve enfatizar a especialização do corpo clínico e a agilidade dos processos. A página inicial deve priorizar o acesso direto aos especialistas e aos procedimentos mais comuns, como biópsias e colocação de cateteres para quimioterapia. O uso de ferramentas como o WhatsApp Business, adotado por 99% dos brasileiros conectados, torna-se essencial para converter consultas de forma imediata e esclarecer dúvidas burocráticas sobre convênios.5 A experiência do usuário (UX) deve transmitir a sensação de um atendimento boutique, onde o paciente é acompanhado de perto por uma equipe multidisciplinar que inclui enfermeiros navegadores e psicólogos, além do cirurgião.7

### **O Hospital e os Serviços Ambulatoriais Especializados**

Para o hospital, o portal digital precisa segmentar sua vasta gama de serviços para oferecer uma porta de entrada específica para procedimentos ambulatoriais. Instituições como o Hospital Nove de Julho organizam o cuidado oncológico através da estrutura da Dasa Oncologia, reunindo diagnóstico, exames e tratamento em blocos exclusivos que garantem a conveniência de realizar toda a jornada em um só lugar.4 A arquitetura do site deve replicar essa organização física, criando seções dedicadas que enfatizam a tecnologia robótica para intervenções de alta complexidade, mas também a eficiência para biópsias de medula e ressecções de pele realizadas com ou sem sedação.4

| Atributo | Foco da Clínica Especializada | Foco do Hospital (Ambulatorial) |
| :---- | :---- | :---- |
| **Objetivo de Conversão** | Agendamento rápido e direto de procedimentos. | Direcionamento para Centros de Referência. |
| **Navegação** | Linear e centrada no especialista. | Hierárquica por subespecialidade oncológica. |
| **Páginas de Procedimento** | Foco em cuidados domiciliares e recuperação rápida. | Enfase na estrutura de suporte (UTI, robótica, exames). |
| **Diferenciais Digitais** | Comunicação personalizada via WhatsApp/Bot. | Portais de resultados de exames e histórico clínico. |
| **Público-alvo** | Pacientes buscando agilidade e menor burocracia. | Pacientes que exigem segurança de infraestrutura completa. |

## **Mapeamento da Jornada do Paciente e Familiar (Patient Journey Mapping)**

O design centrado no paciente (Patient-Centric Design) em oncologia exige um mapeamento rigoroso da jornada, que começa muito antes do agendamento. O processo de "Patient Journey Mapping" (PJM) permite identificar as necessidades emocionais e informacionais em cada etapa, desde os primeiros sintomas até o acompanhamento pós-operatório.8 Na oncologia cirúrgica, essa jornada é marcada por altos níveis de ansiedade, o que demanda uma interface que priorize a previsibilidade e a segurança.10

### **A Jornada de Busca e o Primeiro Contato**

O paciente oncológico ou seu familiar geralmente inicia a busca digital por três caminhos: o nome do médico, um sintoma ou uma especialidade específica.12 Neste estágio de "conscientização", o site deve oferecer conteúdo educativo que valide as preocupações do usuário sem causar pânico. Páginas sobre "lesões suspeitas na pele" ou "preparo para biópsia" servem como portas de entrada valiosas que capturam o usuário no topo do funil.13 A facilidade de encontrar informações sobre convênios atendidos é um dos fatores críticos para a progressão do usuário para a fase de consideração.15

### **Do Agendamento ao Procedimento Ambulatorial**

Na transição da busca para a ação, a eficiência do fluxo de agendamento define a receptividade do paciente. Muitos estabelecimentos ainda dependem do telefone, o que pode causar gargalos e erros.16 A implementação de agendas digitais e sistemas de triagem via WhatsApp permite que a clínica identifique a urgência do caso e solicite a documentação necessária de forma antecipada, reduzindo o estresse no dia da cirurgia.18 O site deve fornecer guias claros sobre o preparo físico, como tempo de jejum para procedimentos com sedação e orientações sobre medicamentos de uso contínuo.20

### **Pós-operatório e Engajamento Contínuo**

Após a intervenção, como a ressecção de uma lesão ou a colocação de um cateter totalmente implantável (Port-a-cath), o paciente entra em uma fase de vulnerabilidade física. O portal deve oferecer uma seção de recursos pós-operatórios com instruções sobre troca de curativos, higiene e sinais de alerta que exigem contato médico.21 Para pacientes que realizaram o implante de cateter, informações didáticas sobre a manutenção periódica (lavagem com solução salina e heparina) são essenciais para evitar complicações como infecções ou trombose.20

## **Arquitetura de Informação: Organização e Estrutura de Menus**

A organização do menu de um portal oncológico deve equilibrar a terminologia médica com a linguagem do leigo. Instituições de referência como o A.C.Camargo organizam sua navegação em pilares que facilitam o acesso tanto para o paciente quanto para o médico parceiro.15

### **Pilares Fundamentais do Menu**

Uma estrutura robusta de IA para oncologia cirúrgica ambulatorial deve conter:

1. **Especialidades e Áreas de Atuação:** Organizadas preferencialmente por tipo de tumor ou órgão (ex: Mama, Pele, Gastrointestinal, Urologia) para facilitar a localização pelo paciente.4  
2. **Procedimentos e Exames:** Uma seção dedicada que diferencie claramente pequenas cirurgias ambulatoriais de grandes intervenções. Incluir subpáginas para Biópsias (Punch, Incisional, Excisional), Colocação de Cateteres e Cirurgia Micrográfica de Mohs.13  
3. **Corpo Clínico e Especialistas:** Perfis detalhados com currículo, RQE, CRM e áreas de interesse. A presença do especialista em vídeos educativos aumenta a percepção de autoridade e confiança.12  
4. **Recursos para Pacientes e Família:** Central de conteúdo com cartilhas, guias de nutrição, orientações sobre direitos sociais e apoio psicológico.25  
5. **Canais de Agendamento e Telemedicina:** Destaque visual para o botão de agendamento online e acesso direto ao portal do paciente para resultados de exames.15

### **Taxonomia por Sintomas e Especialidades**

A pesquisa da Doctoralia indica que a busca por sintomas é uma das mais frequentes.12 Portanto, integrar uma funcionalidade de "O que você está sentindo?" ou uma lista de "Sintomas comuns" que direcione para a especialidade correta é uma tática de UX altamente eficaz. Isso reduz a carga cognitiva do paciente que, em meio ao diagnóstico, pode não saber se deve procurar um cirurgião oncológico ou um mastologista.

| Categoria de Navegação | Exemplos de Conteúdo | Função UX |
| :---- | :---- | :---- |
| **Busca por Órgão/Sistema** | Mama, Próstata, Pulmão, Pele. | Facilita a identificação rápida da patologia. |
| **Busca por Procedimento** | Biópsia, Retirada de Nódulo, Cateter. | Atende quem já possui encaminhamento médico. |
| **Busca por Sintoma** | Nódulo palpável, Mancha suspeita na pele. | Captura o usuário em estágio inicial de dúvida. |
| **Recursos de Apoio** | Guia de Quimioterapia, Manual do Cuidador. | Alivia a ansiedade e educa a família. |

## **Engenharia de UX e Performance Técnica para Oncologia**

A performance técnica de um site de saúde não se resume à velocidade de carregamento (Core Web Vitals), mas envolve a acessibilidade emocional e a inclusão digital. Dado que uma parcela significativa do público oncológico tem mais de 55 anos, a interface deve ser otimizada para legibilidade e facilidade de navegação em dispositivos móveis.28

### **Acessibilidade e Design Emocional**

O design emocional em oncologia visa criar uma sensação de controle. Interfaces confusas, com excesso de animações ou cores agressivas, podem atuar como gatilhos de ansiedade.10 Recomenda-se o uso de uma paleta de cores sóbria, tipografia com alto contraste e botões de ação (CTAs) bem definidos. A previsibilidade é fundamental: o usuário deve saber o que acontece após clicar em um botão — se ele será levado a um formulário, se abrirá um chat no WhatsApp ou se receberá uma ligação.10

### **Otimização para Dispositivos Móveis e Portais do Paciente**

Dados indicam que 60% dos acessos a portais oncológicos ocorrem via smartphones ou tablets.28 Problemas comuns, como a impossibilidade de dar zoom em laudos de exames ou navegação truncada, são barreiras críticas que levam ao abandono do site. O portal do paciente deve ser o núcleo da experiência digital, permitindo o acompanhamento de resultados de biópsias e o histórico de agendamentos de forma intuitiva.15

## **Elementos de Confiança e Alívio da Ansiedade Familiar**

Na oncologia, a decisão pela escolha de uma clínica ou hospital é compartilhada com a família. O site deve, portanto, oferecer elementos de "social proof" e autoridade técnica que validem a competência da instituição.12

### **Certificações e Acreditações**

A exibição de selos de acreditação nacional e internacional é um diferencial de confiança insubstituível. Certificações como as da ONA (Organização Nacional de Acreditação) ou do Einstein Center (referência mundial em oncologia) devem ser destacadas estrategicamente.2 Para serviços de hematologia e transplante, selos como o FACT (Foundation for the Accreditation of Cellular Therapy) conferem autoridade técnica máxima.29

### **Conteúdo Educativo e Apoio ao Cuidador**

O cuidador familiar é o "paciente invisível" que carrega o fardo administrativo e emocional do tratamento. O Manual da Abrale identifica que esses familiares enfrentam medo, insegurança e sobrecarga psicológica.27 Oferecer módulos de conteúdo como "Serei cuidador, e agora?", guias de higiene do sono, nutrição para o cuidador e apoio psicológico gratuito demonstra que a clínica possui uma visão holística e humanizada do tratamento.27

### **O Papel dos Vídeos e Conteúdo Humanizado**

O uso de vídeos com os médicos explicando procedimentos — como as atualizações da ASCO ou o funcionamento de um cateter port-a-cath — humaniza a figura do cirurgião e diminui o medo do desconhecido.24 Ver e ouvir o especialista antes da consulta cria um vínculo inicial de confiança que facilita o acolhimento presencial.

## **Conversão e Fluxos de Agendamento Eficientes**

A "engenharia de conversão" em sites de saúde deve ser sutil e eficaz. O objetivo não é apenas gerar um lead, mas iniciar um processo de triagem qualificada.

### **WhatsApp Business como Canal de Triagem**

No Brasil, o WhatsApp Business revolucionou a comunicação entre clínicas e pacientes. Ele permite confirmar consultas automaticamente, reduzindo faltas em até 60%.5 A estratégia de triagem via WhatsApp deve incluir:

1. **Qualificação Inicial:** Identificar se o paciente já tem diagnóstico ou se busca consulta inicial.  
2. **Coleta de Dados de Convênio:** Verificação imediata de cobertura para o procedimento solicitado.  
3. **Encaminhamento para o Especialista:** Direcionamento do paciente para o profissional mais adequado com base nos sintomas ou exames prévios.19

### **Automação de Solicitações Cirúrgicas**

Para hospitais e clínicas que realizam pequenas cirurgias, a automatização das solicitações de autorização junto aos convênios é um diferencial de produtividade. Sistemas digitais integrados permitem que o médico emita a solicitação de qualquer lugar, reduzindo o tempo de espera do paciente e otimizando o fluxo de caixa da instituição.18

| Canal de Conversão | Melhor Uso | Vantagem UX |
| :---- | :---- | :---- |
| **Botão WhatsApp Fixo** | Dúvidas rápidas e agendamento imediato. | Familiaridade e rapidez.5 |
| **Formulário de Agendamento** | Solicitações detalhadas de procedimentos. | Organização de dados para triagem.18 |
| **Telemedicina** | Consultas de segunda opinião ou triagem. | Conveniência e acesso remoto.15 |
| **Portal do Paciente** | Acesso a laudos e histórico. | Autonomia e transparência.28 |

## **Diferenciação Técnica: Procedimentos Ambulatoriais em Foco**

Um dos erros mais comuns em sites de oncologia é tratar todos os procedimentos cirúrgicos com o mesmo peso visual e informacional. É imperativo diferenciar a "grande cirurgia oncológica" (que exige internação e UTI) dos "procedimentos ambulatoriais e pequenas cirurgias".

### **Páginas de Procedimentos Específicos**

Cada procedimento ambulatorial deve possuir uma "Landing Page" dedicada, otimizada para SEO e com foco em esclarecimento de dúvidas.

#### **Colocação de Cateter Port-a-cath e PICC**

O site deve explicar as diferenças fundamentais entre o Port-a-cath (totalmente implantável, menor risco de infecção, ideal para tratamentos longos) e o PICC (perifericamente inserido, com parte exposta, exige cuidados semanais).20 Detalhar que a instalação do Port-a-cath ocorre em ambiente cirúrgico sob anestesia local e dura cerca de 30 a 60 minutos alivia a ansiedade do paciente.20

#### **Biópsias de Pele e Ressecções**

Para pacientes com suspeita de câncer de pele, o portal deve detalhar as técnicas de biópsia:

* **Shaving:** Raspagem das camadas superficiais para lesões exofíticas.  
* **Punch:** Remoção de um cilindro de tecido para análise de profundidade.  
* **Incisional/Excisional:** Retirada parcial ou total de tumores localizados em camadas profundas.13

O conteúdo deve enfatizar que esses procedimentos são geralmente rápidos, causam desconforto mínimo semelhante a uma coleta de sangue e utilizam anestesia local.23

## **Estratégias de SEO e Autoridade Digital (Long Tail em Oncologia)**

A estratégia de busca para uma clínica oncológica deve focar em palavras-chave de cauda longa (long tail) que refletem a intenção real do paciente. Termos genéricos como "câncer" são dominados por grandes portais informativos, mas termos específicos como "preparo para biópsia de pele punch em São Paulo" ou "cuidados com curativo de cateter port-a-cath" atraem um tráfego qualificado e pronto para a conversão.14

### **Conteúdo como Motor de Ranqueamento**

O Google prioriza sites de saúde que demonstram E-E-A-T (Expertise, Experience, Authoritativeness, and Trustworthiness). Publicar guias de conduta baseados nas diretrizes da SBOC (Sociedade Brasileira de Oncologia Clínica) e manter o conteúdo atualizado com os últimos avanços da medicina diagnóstica são práticas que elevam o ranking orgânico.24

## **Tendências em Saúde Digital e UX para 2025**

O futuro da oncologia digital no Brasil aponta para uma integração cada vez maior entre inteligência artificial e personalização do cuidado. As tendências para 2025 incluem:

1. **IA Generativa para Suporte ao Paciente:** Chatbots avançados capazes de explicar diagnósticos de forma simplificada e responder a dúvidas sobre efeitos colaterais em tempo real.34  
2. **Monitoramento Remoto (Wearables):** Integração de dados de dispositivos vestíveis ao portal do paciente para monitorar a recuperação após pequenas cirurgias e identificar sinais de complicações precocemente.34  
3. **Medicina de Precisão e Big Data:** Portais que oferecem informações personalizadas com base no perfil genômico do paciente, permitindo uma jornada de tratamento "sob medida".35  
4. **Cuidado Mental Integrado:** Expansão de programas de apoio psicológico via telemedicina, integrando a saúde física e mental no mesmo ambiente digital.31

## **Estrutura Recomendada para o Guia de Site de Oncologia**

Com base na análise técnica e nas necessidades do setor, um site de oncologia cirúrgica ambulatorial de alta performance deve seguir o seguinte guia estrutural:

### **Arquitetura de Informação (Site Mapping)**

* **Home:** Foco em proposta de valor (humanização \+ tecnologia), busca inteligente e CTAs claros.  
* **Especialidades:** Páginas divididas por sistemas corporais com foco em oncologia cirúrgica.  
* **Procedimentos:** Destaque para Biópsias, Cateteres e Ressecções de Pele.  
* **Preparo do Paciente:** Hub de cartilhas, vídeos de orientação e manuais de jejum.  
* **Apoio à Família:** Espaço do cuidador, direitos do paciente e apoio psicológico.  
* **Corpo Clínico:** Currículos humanizados com fotos e especialidades.  
* **Blog/Notícias:** Atualizações científicas e artigos educativos.  
* **Contatos/Unidades:** Localização facilitada com integração ao Google Maps e agendamento via WhatsApp.

### **Checklist de UX e Trust Elements**

* **Velocidade:** Carregamento em menos de 2 segundos.  
* **Mobile-First:** Navegação otimizada para o polegar e fontes escaláveis.  
* **Selos de Confiança:** ONA, FACT, JCI visíveis.  
* **Segurança de Dados:** Conformidade total com a LGPD em todos os formulários.  
* **Acolhimento:** Linguagem empática e direta, evitando jargões excessivos sem explicação.

A integração desses elementos cria um portal que transcende a função informativa, tornando-se um componente vital no tratamento oncológico. Ao focar na jornada ambulatorial e nas necessidades da família, a instituição não apenas aumenta suas taxas de conversão, mas consolida sua reputação como uma referência em cuidado humanizado e eficiência cirúrgica no Brasil. A oncologia do futuro é digital, ágil e, acima de tudo, centrada na experiência humana.

#### **Referências citadas**

1. Oncoclínicas \- Referência em tratamento oncológico | Referência em tratamento oncológico, acessado em fevereiro 23, 2026, [https://grupooncoclinicas.com/](https://grupooncoclinicas.com/)  
2. Centro de oncologia do Albert Einstein é eleito o melhor da América Latina \- Revista Veja, acessado em fevereiro 23, 2026, [https://veja.abril.com.br/saude/centro-de-oncologia-do-einstein-e-eleito-o-melhor-da-america-latina/](https://veja.abril.com.br/saude/centro-de-oncologia-do-einstein-e-eleito-o-melhor-da-america-latina/)  
3. Einstein Center for Advanced Therapies in Oncology and Hematology, acessado em fevereiro 23, 2026, [https://www.einstein.br/n/en/units/einstein-center-advanced-therapies-oncology-and-hematology](https://www.einstein.br/n/en/units/einstein-center-advanced-therapies-oncology-and-hematology)  
4. Oncologia em São Paulo | Hospital Nove de Julho, acessado em fevereiro 23, 2026, [https://www.h9j.com.br/especialidades/oncologia/](https://www.h9j.com.br/especialidades/oncologia/)  
5. WhatsApp Business para clínicas: guia prático | Growth Marketing para Negócios de Saúde e Bem-Estar | WeCon, acessado em fevereiro 23, 2026, [https://wecondigital.com.br/whatsapp-business-para-clinicas-guia-pratico/](https://wecondigital.com.br/whatsapp-business-para-clinicas-guia-pratico/)  
6. Tecnologias na área da Saúde: o uso do WhatsApp para agendamento de consultas médicas | Pluri Sistemas, acessado em fevereiro 23, 2026, [https://plurisistemas.com/whatsapp-para-agendamento-de-consultas-medicas/](https://plurisistemas.com/whatsapp-para-agendamento-de-consultas-medicas/)  
7. Oncologia: encontre o centro mais próximo de você | Rede Américas, acessado em fevereiro 23, 2026, [https://www.saudeamericas.com.br/oncologia/](https://www.saudeamericas.com.br/oncologia/)  
8. Patient Journey Mapping \- UX Design Innovation Studio \- Frontend.com, acessado em fevereiro 23, 2026, [https://www.frontend.com/our-services/patient-journey-mapping/](https://www.frontend.com/our-services/patient-journey-mapping/)  
9. Patient research journey. Methods for mapping patient experience \- Agencja UX, acessado em fevereiro 23, 2026, [https://thestory.is/en/journal/patient-journey/](https://thestory.is/en/journal/patient-journey/)  
10. Design emocional e acessibilidade emocional: quando o design precisa cuidar das emoções | by Vitor David | UX Collective, acessado em fevereiro 23, 2026, [https://brasil.uxdesign.cc/design-emocional-e-acessibilidade-emocional-quando-o-design-precisa-cuidar-das-emo%C3%A7%C3%B5es-be61a629a736](https://brasil.uxdesign.cc/design-emocional-e-acessibilidade-emocional-quando-o-design-precisa-cuidar-das-emo%C3%A7%C3%B5es-be61a629a736)  
11. UX e acessibilidade para pessoas com transtorno de ansiedade | by Bruna Freitas Toldo, acessado em fevereiro 23, 2026, [https://brasil.uxdesign.cc/ux-e-acessibilidade-para-pessoas-com-transtornos-de-ansiedade-6e553b9a0f3](https://brasil.uxdesign.cc/ux-e-acessibilidade-para-pessoas-com-transtornos-de-ansiedade-6e553b9a0f3)  
12. Site para hospitais e clínicas: 5 vantagens e como otimizá-lo \- Doctoralia Pro, acessado em fevereiro 23, 2026, [https://pro.doctoralia.com.br/blog/clinicas/site-para-hospitais-e-clinicas-principais-vantagens-e-como-otimizar](https://pro.doctoralia.com.br/blog/clinicas/site-para-hospitais-e-clinicas-principais-vantagens-e-como-otimizar)  
13. Biópsia para diagnóstico do câncer de pele basocelular e espinocelular | Instituto Oncoguia, acessado em fevereiro 23, 2026, [https://www.oncoguia.org.br/conteudo/biopsia-para-diagnostico-do-cancer-de-pele-basocelular-e-espinocelular/1219/269/](https://www.oncoguia.org.br/conteudo/biopsia-para-diagnostico-do-cancer-de-pele-basocelular-e-espinocelular/1219/269/)  
14. Palavras-chave de cauda longa: Como usar na sua estratégia \- Conversion, acessado em fevereiro 23, 2026, [https://www.conversion.com.br/blog/palavras-chave-de-cauda-longa/](https://www.conversion.com.br/blog/palavras-chave-de-cauda-longa/)  
15. A.C.Camargo Cancer Center, acessado em fevereiro 23, 2026, [https://www.accamargo.org.br/](https://www.accamargo.org.br/)  
16. Software médico oncológico: melhores soluções para transformar sua clínica \- Interprocess, acessado em fevereiro 23, 2026, [https://interprocess.com.br/software-medico-oncologico-melhores-para-sua-clinica/](https://interprocess.com.br/software-medico-oncologico-melhores-para-sua-clinica/)  
17. 10 práticas recomendadas de agendamento no setor de saúde | Doodle, acessado em fevereiro 23, 2026, [https://doodle.com/pt\_BR/10-best-practices-for-scheduling-in-the-healthcare-industry/](https://doodle.com/pt_BR/10-best-practices-for-scheduling-in-the-healthcare-industry/)  
18. Dicas de como deixar o processo de agendamento mais eficiente \- Blog Intelectah, acessado em fevereiro 23, 2026, [https://blog.intelectah.com.br/dicas-processo-de-agendamento-mais-eficiente/](https://blog.intelectah.com.br/dicas-processo-de-agendamento-mais-eficiente/)  
19. Triagem de pacientes no WhatsApp: qualificando antes do agendamento \- Cloudia, acessado em fevereiro 23, 2026, [https://www.cloudia.com.br/triagem-pacientes-whatsapp/](https://www.cloudia.com.br/triagem-pacientes-whatsapp/)  
20. Cateter para quimioterapia: Como é a aplicação e os cuidados, acessado em fevereiro 23, 2026, [https://www.draleticialauricella.com.br/cateter-para-quimioterapia](https://www.draleticialauricella.com.br/cateter-para-quimioterapia)  
21. Caterer para quimioterapia: Orientações ao paciente – Doutor Sabas – Prevenção e Tratamento do Câncer de Mama, acessado em fevereiro 23, 2026, [https://doutorsabas.com.br/caterer-para-quimioterapia-orientacoes-ao-paciente/](https://doutorsabas.com.br/caterer-para-quimioterapia-orientacoes-ao-paciente/)  
22. Tudo sobre Cateter Port-a-Cath | Oncoclínicas, acessado em fevereiro 23, 2026, [https://grupooncoclinicas.com/tudo-sobre-o-cancer/tratamentos-para-o-cancer/port-a-cath/](https://grupooncoclinicas.com/tudo-sobre-o-cancer/tratamentos-para-o-cancer/port-a-cath/)  
23. Biópsia de pele: o primeiro passo \- AIM na Fundação Melanoma, acessado em fevereiro 23, 2026, [https://www.aimatmelanoma.org/pt/melanoma-101/rec%C3%A9m-diagnosticado/bi%C3%B3psia-de-pele%3A-o-primeiro-passo/](https://www.aimatmelanoma.org/pt/melanoma-101/rec%C3%A9m-diagnosticado/bi%C3%B3psia-de-pele%3A-o-primeiro-passo/)  
24. Medicina diagnóstica: avanços da terapia oncológica | Einstein na ASCO 2024 \- YouTube, acessado em fevereiro 23, 2026, [https://www.youtube.com/watch?v=9yA8s9Xua9A](https://www.youtube.com/watch?v=9yA8s9Xua9A)  
25. Orientações aos pacientes e familiares — Instituto Nacional de Câncer \- INCA, acessado em fevereiro 23, 2026, [https://www.gov.br/inca/pt-br/assuntos/cancer/orientacoes-aos-pacientes-e-familiares](https://www.gov.br/inca/pt-br/assuntos/cancer/orientacoes-aos-pacientes-e-familiares)  
26. Orientações aos pacientes e familiares | INCA \- Instituto Nacional de Câncer, acessado em fevereiro 23, 2026, [https://www.inca.gov.br/tratamento/orientacoes-aos-pacientes-e-familiares](https://www.inca.gov.br/tratamento/orientacoes-aos-pacientes-e-familiares)  
27. Manual Abrale \- CUIDANDO DO CUIDADOR | 1, acessado em fevereiro 23, 2026, [https://abrale.org.br/wp-content/uploads/2023/08/Manual-Abrale-Cuidando-do-Cuidador-web.pdf](https://abrale.org.br/wp-content/uploads/2023/08/Manual-Abrale-Cuidando-do-Cuidador-web.pdf)  
28. A Vision for NC's Patient Portal \- ROSE HESSE UX Design & Strategy, acessado em fevereiro 23, 2026, [https://rosehesse.com/nc-patient-portalivision/](https://rosehesse.com/nc-patient-portalivision/)  
29. Dossiê de Valor 2024 \- Einstein Hospital Israelita, acessado em fevereiro 23, 2026, [https://www.einstein.br/DocumentosAcessoLivre/Dossie-2024-6.pdf](https://www.einstein.br/DocumentosAcessoLivre/Dossie-2024-6.pdf)  
30. COMISSÃO DE DEFESA DOS DIREITOS DOS PACIENTES ONCOLÓGICOS E EM CUIDADOS PALIATIVOS \- OABRJ, acessado em fevereiro 23, 2026, [https://oabrj.org.br/sites/default/files/cartilha\_final-1.pdf](https://oabrj.org.br/sites/default/files/cartilha_final-1.pdf)  
31. Tendências da Saúde para 2025: novidades e o que deve vir \- Hospital Sírio-Libanês, acessado em fevereiro 23, 2026, [https://hospitalsiriolibanes.org.br/blog/paranegocios/tendencias-saude-2025-novidades](https://hospitalsiriolibanes.org.br/blog/paranegocios/tendencias-saude-2025-novidades)  
32. Cauda Longa: o que é e como usar as palavras-chave desse tipo? \- RD Station, acessado em fevereiro 23, 2026, [https://www.rdstation.com/blog/marketing/cauda-longa/](https://www.rdstation.com/blog/marketing/cauda-longa/)  
33. Diretrizes 2025 \- Sociedade Brasileira de Oncologia Clínica, acessado em fevereiro 23, 2026, [https://sboc.org.br/diretrizes2025](https://sboc.org.br/diretrizes2025)  
34. Conheça as principais tendências de 2025 em Saúde Digital, acessado em fevereiro 23, 2026, [https://digitalmedicina.com.br/2024/12/30/conheca-as-principais-tendencias-de-2025-em-saude-digital/](https://digitalmedicina.com.br/2024/12/30/conheca-as-principais-tendencias-de-2025-em-saude-digital/)  
35. 5 tendências de tecnologia na saúde para 2025 \- Blog Leve Saúde, acessado em fevereiro 23, 2026, [https://www.levesaude.com.br/blog/planos-de-saude/5-tendencias-de-tecnologia-na-saude-para-2025](https://www.levesaude.com.br/blog/planos-de-saude/5-tendencias-de-tecnologia-na-saude-para-2025)  
36. Câncer: tecnologias inovadoras e equidade de acesso foram destaques de congresso internacional em São Paulo | Oncoclínicas, acessado em fevereiro 23, 2026, [https://grupooncoclinicas.com/releases/cancer-tecnologias-inovadoras-e-equidade-de-acesso-foram-destaques-de-congresso-internacional-em-sao-paulo/](https://grupooncoclinicas.com/releases/cancer-tecnologias-inovadoras-e-equidade-de-acesso-foram-destaques-de-congresso-internacional-em-sao-paulo/)