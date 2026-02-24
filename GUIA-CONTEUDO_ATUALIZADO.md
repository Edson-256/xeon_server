# Guia de Conteúdo — Site Clínica Michalkcare

Guia prático para editar páginas existentes e criar novos artigos de especialidades.

---

## Visão Geral da Estrutura

```
clinica-website/
├── src/content/especialidades/    ← Artigos em Markdown (aqui você edita)
│   ├── oncologia-hepatica.md
│   ├── oncologia-coloretal.md
│   ├── cancer_de_mama.md
│   ├── cancer_de_prostata.md
│   ├── cancer_de_pele.md
│   └── cancer_colorretal.md
├── src/content/config.ts          ← Schema (define campos obrigatórios)
├── public/images/                 ← Imagens do site (coloque imagens aqui)
├── dist/                          ← Site compilado (gerado pelo build)
└── scripts/deploy.sh              ← Script de deploy
```

**Fluxo resumido (MODELO ATUAL — Opção A):** Mac (Editar/Commit/Push/Build/Deploy) → Servidor Xeon (recebe `dist/`)

```
Mac (modifica `src/`, faz `git push`) → Mac (`npm run build`) → Mac (`rsync` via Tailscale) → Servidor Xeon (`/var/www/michalkcare/dist`)
```

✅ **Onde rodar o deploy:** **NO MAC**, dentro de `clinica-website/` (raiz do projeto Astro).  
🚫 **O servidor NÃO faz `git pull`, NÃO roda `npm run build` e NÃO faz commit.**

---

## Deploy via Tailscale (recomendado)

O deploy usa Tailscale (rede `100.x`) e SSH na porta **2222**.

No **Mac**, configure um alias em `~/.ssh/config`:

```sshconfig
Host xeon-vpn
  HostName 100.107.166.67
  User edson
  Port 2222
```

O `scripts/deploy.sh` deve usar `xeon-vpn` como destino.

---

## Publicação no Servidor (Servidor como destino estático)

O servidor Xeon deve ser tratado como **destino de publicação**: ele apenas hospeda os arquivos finais em `/var/www/michalkcare/dist/`.

### Regra operacional

* **Mac (repo com `origin`)**: onde você edita, commita, dá `git push`, roda o build e faz o deploy.
* **Servidor (destino)**: onde você **não edita**; apenas recebe `dist/` via `rsync`.

### Checklist no Mac (publicação)

1. Editar conteúdo (`src/content/...`) e imagens (`public/images/...`)
2. `git add -A && git commit -m "..." && git push`
3. **Build + Deploy (NO MAC):** `./scripts/deploy.sh` (rodar dentro de `clinica-website/`)


## 1. Fazer Mudanças Pontuais em Páginas Existentes

### Exemplo: Adicionar uma imagem a um artigo

#### Manualmente

**Passo 1 — Colocar a imagem na pasta pública**

```bash
# Copiar a imagem para a pasta de imagens do site
cp /caminho/da/sua/imagem.jpg ~/dev/xeon-website/site/clinica-website/public/images/
```

> **Dica:** Use nomes descritivos e sem espaços. Exemplo: `cancer-mama-mamografia.jpg`
> Formatos recomendados: `.jpg`, `.png`, `.webp` (webp é mais leve)

**Passo 2 — Inserir a imagem no artigo Markdown**

Abra o arquivo do artigo com qualquer editor de texto:

```bash
nano ~/dev/xeon-website/site/clinica-website/src/content/especialidades/cancer_de_mama.md
```

No local desejado do texto, adicione:

```markdown
![Descrição da imagem para acessibilidade](/images/cancer-mama-mamografia.jpg)
```

> A descrição entre colchetes `[...]` é o texto alternativo (alt text).
> Importante para acessibilidade e SEO.

**Passo 3 — Salvar e Enviar para o Git (Mac)**

No seu **Mac**, salve e envie para o repositório remoto:
```bash
git add .
git commit -m "update: adicionando imagem no artigo de mama"
git push
```

**Passo 4 — Fazer build e deploy (🖥️ NO MAC 🖥️)**

Execute **no Mac**, dentro de `clinica-website/` (raiz do projeto Astro):

```bash
cd ~/dev/xeon-website/site/clinica-website
./scripts/deploy.sh
```

Opcional (simular sem enviar arquivos):
```bash
./scripts/deploy.sh --dry-run
```

**Passo 5 — Verificar no navegador**

Acesse a página alterada: `https://www.michalkcare.com/especialidades/cancer_de_mama/`

#### Com ajuda da IA (Claude Code)

Basta descrever o que quer. Exemplos:

```
"Adicione a imagem mama-diagrama.jpg ao artigo de câncer de mama,
logo após a seção 'O Que É o Câncer de Mama?'"
```

```
"Corrija o texto da seção de fatores de risco no artigo de câncer de próstata"
```

```
"Atualize a estatística de incidência no artigo de câncer de mama
para os dados de 2026"
```

A IA vai editar o arquivo, rodar o build e fazer o deploy automaticamente.

### Outros exemplos de mudanças pontuais

| O que mudar | O que editar | Exemplo no Markdown |
|------------|-------------|-------------------|
| Texto/parágrafos | Editar o `.md` diretamente | Alterar o texto no local desejado |
| Adicionar imagem | Copiar para `public/images/` + inserir no `.md` | `![Alt](/images/foto.jpg)` |
| Adicionar link | Editar o `.md` | `[texto do link](https://url.com)` |
| Tabela | Editar o `.md` | Ver sintaxe Markdown para tabelas |
| Negrito/Itálico | Editar o `.md` | `**negrito**` / `*itálico*` |
| Remover seção | Deletar o trecho do `.md` | Apagar as linhas |

> **Lembre-se:** Faça suas mudanças no Mac, faça `git push`, e publique rodando **NO MAC**: `./scripts/deploy.sh` (a partir de `clinica-website/`).

---

## 2. Adicionar um Novo Artigo de Especialidade

### Fluxo Completo

#### Manualmente

**Passo 1 — Criar o arquivo Markdown**

Crie um novo arquivo `.md` na pasta de especialidades:

```bash
nano ~/dev/xeon-website/site/clinica-website/src/content/especialidades/nome_da_doenca.md
```

> **Nomenclatura:** Use letras minúsculas, underline `_` entre palavras.
> Exemplos: `cancer_de_tireoide.md`, `sarcomas.md`, `tumores_cerebrais.md`

**Passo 2 — Escrever o frontmatter (cabeçalho obrigatório)**

Todo artigo DEVE começar com este bloco entre `---`:

```yaml
---
title: "Título da Página — Aparece no navegador e no topo"
description: "Descrição curta para SEO (Google). 1-2 frases."
excerpt: "Resumo que aparece no card da listagem de especialidades (~150 caracteres)."
order: 7
author: "Dr. Edson Michalkiewicz"
pubDate: "2026-02-22"
tags: ["Tag1", "Oncologia", "Prevenção"]
---
```

**Campos obrigatórios:**

| Campo | O que é | Exemplo |
|-------|---------|---------|
| `title` | Título completo da página | `"Câncer de Tireoide: Guia Completo"` |
| `description` | Descrição para SEO (Google) | `"Informações sobre diagnóstico e tratamento..."` |
| `excerpt` | Resumo curto para o card na listagem | `"Saiba tudo sobre o câncer de tireoide."` |

**Campos opcionais:**

| Campo | O que é | Padrão se omitido |
|-------|---------|-------------------|
| `order` | Posição na listagem (menor = primeiro) | 99 (vai pro final) |
| `author` | Nome do autor | Não exibido |
| `pubDate` | Data de publicação | Não exibido |
| `tags` | Lista de categorias | Nenhuma |

**Referência de order (posições atuais):**

| Order | Artigo |
|-------|--------|
| 1 | Oncologia Hepática |
| 2 | Oncologia Colorretal |
| 3 | Câncer de Mama |
| 4 | Câncer de Próstata |
| 5 | Câncer de Pele |
| 6 | Câncer Colorretal |
| 7+ | Próximos artigos |

**Passo 3 — Escrever o conteúdo**

Abaixo do frontmatter, escreva em Markdown normal:

```markdown
---
title: "Câncer de Tireoide: Guia para Pacientes"
description: "Informações sobre prevenção, diagnóstico e tratamento do câncer de tireoide."
excerpt: "Guia completo sobre o câncer de tireoide: sintomas, diagnóstico e opções de tratamento."
order: 7
author: "Dr. Edson Michalkiewicz"
pubDate: "2026-03-15"
tags: ["Câncer de Tireoide", "Oncologia", "Tratamento"]
---

# Câncer de Tireoide: Guia para Pacientes

**Dr. Edson Michalkiewicz — Cirurgião Oncológico**
*CRM 12328 | RQE 9742*

---

## Introdução

O câncer de tireoide é um dos tipos mais tratáveis de câncer...

## Fatores de Risco

- **Exposição à radiação** — especialmente na infância
- **Histórico familiar** — de câncer de tireoide
...

## Diagnóstico

### Ultrassonografia
A ultrassonografia da tireoide é o principal exame...

## Tratamento

### Cirurgia (Tireoidectomia)
A remoção cirúrgica é o tratamento principal...

---

*Conteúdo elaborado pelo Dr. Edson Michalkiewicz — Cirurgião Oncológico*
*CRM 12328 | RQE 9742*
```

**Passo 4 — Salvar no Git (Mac)**

Envie o novo artigo para o repositório remoto a partir do seu Mac:

```bash
git add src/content/especialidades/nome_da_doenca.md
git commit -m "feat(content): add artigo sobre nome_da_doenca"
git push
```

**Passo 5 — Build e Deploy (⚠️ SERVIDOR XEON ⚠️)**

Acesse seu **Servidor Xeon via SSH** para baixar o artigo e fazer o build:

```bash
# ⚠️ ATENÇÃO: Execute APENAS no Servidor Xeon ⚠️
cd /caminho/do/site/no/servidor
git pull
npm ci && npm run build
```

Se o build der erro, provavelmente falta algum campo obrigatório no frontmatter. Corrija o arquivo no Mac, faça push novamente, e dê git pull no Servidor Xeon.

Se o build passar, conclua a publicação **no Mac** com:

```bash
cd ~/dev/xeon-website/site/clinica-website
./scripts/deploy.sh
```

**Passo 6 — Verificar**

- `https://www.michalkcare.com/especialidades/` → o novo card deve aparecer
- `https://www.michalkcare.com/especialidades/nome_da_doenca/` → a página completa

#### Com ajuda da IA (Claude Code)

Abra o Claude Code no terminal e descreva o que precisa:

```
"Crie um artigo sobre câncer de tireoide para o site, seguindo o
mesmo padrão dos artigos existentes. Use order 7."
```

Ou, se já tiver o texto pronto:

```
"Adicione este artigo como nova especialidade no site: [cole o texto]"
```

A IA vai:
1. Criar o arquivo `.md` com frontmatter correto
2. Rodar o build
3. Fazer o deploy para produção
4. (Opcional) Fazer commit/push no git (preferencialmente no Mac)

---

## 3. Referência Rápida de Comandos

### Checklist — Mudança Pontual

```bash
# 🖥️ NO MAC:
# 1. Editar o arquivo e copiar imagens (se necessário)
nano ~/dev/xeon-website/site/clinica-website/src/content/especialidades/ARQUIVO.md
cp imagem.jpg ~/dev/xeon-website/site/clinica-website/public/images/

# 2. Commit & Push
git add -A && git commit -m "update: descrição da mudança" && git push

# 3) Build & Deploy (NO MAC)
cd ~/dev/xeon-website/site/clinica-website && ./scripts/deploy.sh
```

### Checklist — Novo Artigo

```bash
# 🖥️ NO MAC:
# 1. Criar arquivo com frontmatter + conteúdo
nano ~/dev/xeon-website/site/clinica-website/src/content/especialidades/novo_artigo.md

# 2. Commit & Push
git add src/content/especialidades/novo_artigo.md
git commit -m "feat(content): add artigo sobre [tema]"
git push

# 3) Build & Deploy (NO MAC)
cd ~/dev/xeon-website/site/clinica-website && ./scripts/deploy.sh
```

### Checklist — Com IA

```
1. Abrir terminal
2. Digitar: claude
3. Descrever o que precisa em português
4. A IA faz tudo (edita, build, deploy, git)
5. Verificar no navegador
```

---

## 4. Resolução de Problemas

### "O build deu erro de validação"

O erro vai indicar qual campo está faltando. Exemplo:

```
especialidades → cancer_de_mama.md frontmatter does not match collection schema.
"excerpt" is required
```

**Solução:** Adicione o campo `excerpt` no frontmatter do arquivo indicado.

### "A página não aparece no site"

Verifique se fez o deploy:

```bash
ls /var/www/michalkcare/dist/especialidades/
```

Se o novo artigo não está lá, rode:

Acesse o **Servidor Xeon** e rode:

```bash
cd /caminho/do/site/no/servidor
git pull
npm run build
rsync -av --delete dist/ /var/www/michalkcare/dist/
```

### "A imagem não aparece"

1. Confirme que a imagem está em `public/images/`
2. Confirme que o caminho no Markdown começa com `/images/` (com barra no início)
3. Rode o build e deploy novamente

### "Mudei o arquivo mas o site não atualizou"

O navegador pode estar com cache. Tente:
- `Ctrl + Shift + R` (recarregar sem cache)
- Ou abrir em aba anônima

---

## 5. Sintaxe Markdown — Referência Rápida

```markdown
# Título Principal (H1)
## Seção (H2)
### Subseção (H3)

Parágrafo normal com **negrito** e *itálico*.

- Item de lista
- Outro item
  - Sub-item

1. Lista numerada
2. Segundo item

[Texto do link](https://url.com)

![Descrição da imagem](/images/foto.jpg)

> Citação ou destaque

| Coluna 1 | Coluna 2 |
|----------|----------|
| Dado 1   | Dado 2   |

---  (linha horizontal)
```
