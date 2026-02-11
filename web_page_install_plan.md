# Plano de Recuperação Rápida - Verificação Meta Business API

## Objetivo

Desbloquear a API do WhatsApp Business através do deploy rápido de um site funcional em
http://www.michalkcare.com com HTTPS e credenciais corporativas.

---
## Análise do Estado Atual

### Projeto Existente (clinica-website)

 - Framework: Astro 5.17.1 (SSG) com Tailwind CSS
 - Status: 90% completo - 10 páginas funcionais
 - Build: Pronto (620 KB otimizado)
 - Nginx: Config profissional já existe
 - Deploy Script: Configurado (precisa ajuste de host)

### Dados Corporativos REAIS (Meta Business Manager)

 {
   "razaoSocial": "EDSON LUIZ MICHALKIEWICZ - CLINICA E SERVICOS MEDICOS EIRELI",
   "cnpj": "31.763.533/0001-59",
   "endereco": "Rua Roberto Brzezinski, 2052 - Campo Mourão, PR 87.302-200",
   "whatsapp": "+55 44 3016-2003",
   "whatsappBloqueado": "+55 44 3144-4560"
 }

 Problema de Domínio

 - Projeto configurado para: clinicaedson.com.br / clinicaoncologia.com.br
 - Domínio Meta: www.michalkcare.com
 - Decisão necessária: Qual domínio usar?

 ---
 DECISÃO ESTRATÉGICA: Qual Caminho é Mais Rápido?

 Opção A: Deploy do Projeto Completo (Recomendado)

 Tempo estimado para primeira versão online: 2-4 horas
 ┌────────────────────────────────────┬────────────────────────────────────────────────┐
 │              Vantagem              │                  Desvantagem                   │
 ├────────────────────────────────────┼────────────────────────────────────────────────┤
 │ Site profissional e completo       │ Precisa atualizar configs para michalkcare.com │
 ├────────────────────────────────────┼────────────────────────────────────────────────┤
 │ Footer já tem estrutura para dados │ Precisa preencher dados reais (CNPJ, WhatsApp) │
 ├────────────────────────────────────┼────────────────────────────────────────────────┤
 │ Nginx config pronto                │ Precisa validar se todos componentes funcionam │
 ├────────────────────────────────────┼────────────────────────────────────────────────┤
 │ SEO e LGPD já implementados        │ Mais arquivos para revisar                     │
 └────────────────────────────────────┴────────────────────────────────────────────────┘
 Opção B: Landing Page Express

 Tempo estimado: 1-2 horas
 ┌──────────────────────────┬────────────────────────────────────────┐
 │         Vantagem         │              Desvantagem               │
 ├──────────────────────────┼────────────────────────────────────────┤
 │ Mínimo de código         │ Site "pobre" pode afetar credibilidade │
 ├──────────────────────────┼────────────────────────────────────────┤
 │ Rápido de subir          │ Não aproveita trabalho já feito        │
 ├──────────────────────────┼────────────────────────────────────────┤
 │ Foco total em compliance │ Precisará refazer depois               │
 └──────────────────────────┴────────────────────────────────────────┘
 Opção C: Hybrid (RECOMENDADO FINAL)

 Deploy do projeto existente com ajustes mínimos
 - Usa a estrutura completa
 - Atualiza apenas os dados críticos (CNPJ, WhatsApp, domínio)
 - Faster time-to-compliance

 ---
 PLANO DE AÇÃO (Opção C - Hybrid)

 Fase 1: Preparação de Dados (15 min)

 Arquivos a modificar:

 1. src/data/clinic.json
   - Atualizar CNPJ real
   - Preencher WhatsApp com número oficial
   - Atualizar CRM/RQE se necessário
   - Confirmar endereço físico
 2. astro.config.mjs
   - Alterar SITE_URL para https://www.michalkcare.com
 3. public/robots.txt
   - Atualizar sitemap URL para michalkcare.com

 Fase 2: Configuração DNS (30 min - depende do registrar)

 Ações no painel DNS do domínio michalkcare.com:

 # Registro A - apontar para IP do xeon_server
 @         A       187.95.108.109
 www       A       187.95.108.109

 TTL recomendado: 300 (5 min) para propagação rápida

 Passo a passo no Squarespace Domains (via Google Workspace):

 1. Acesse: https://domains.squarespace.com/
 2. Faça login com sua conta Google Workspace
 3. Selecione o domínio michalkcare.com
 4. Vá em DNS → DNS Settings ou Custom Records
 5. MANTER o registro existente:
 ┌──────┬──────┬──────────────┬─────┬─────────────┐
 │ Type │ Host │     Data     │ TTL │   Status    │
 ├──────┼──────┼──────────────┼─────┼─────────────┤
 │ A    │ n8n  │ 31.97.19.152 │ -   │ ✓ NÃO MEXER │
 └──────┴──────┴──────────────┴─────┴─────────────┘
 6. ADICIONAR novos registros:
 ┌──────┬──────┬────────────────┬─────┐
 │ Type │ Host │      Data      │ TTL │
 ├──────┼──────┼────────────────┼─────┤
 │ A    │ @    │ 187.95.108.109 │ 300 │
 ├──────┼──────┼────────────────┼─────┤
 │ A    │ www  │ 187.95.108.109 │ 300 │
 └──────┴──────┴────────────────┴─────┘
 7. NÃO remova o registro do n8n - ele continua funcionando
 8. Salve as alterações

 Resultado final:
 - michalkcare.com → xeon_server (site público)
 - www.michalkcare.com → xeon_server (site público)
 - n8n.michalkcare.com → VPS Hostinger (n8n + dados) ✓ continua funcionando

 Verificar propagação (após 5-30 min):
 # Na máquina local ou servidor
 dig +short michalkcare.com
 dig +short www.michalkcare.com
 # Ambos devem retornar: 187.95.108.109

 # Ou via web: https://dnschecker.org/#A/michalkcare.com

 Fase 3: Configuração do Servidor (30 min)

 No xeon_server (187.95.108.109):

 # 1. Instalar Certbot
 sudo snap install --classic certbot
 sudo ln -s /snap/bin/certbot /usr/bin/certbot

 # 2. Preparar diretório de deploy
 sudo mkdir -p /var/www/michalkcare/dist
 sudo chown -R $USER:$USER /var/www/michalkcare

 # 3. Criar config Nginx
 sudo nano /etc/nginx/sites-available/michalkcare.conf
 # (colar conteúdo do nginx/clinica.conf adaptado - ver abaixo)

 # 4. Ativar site
 sudo ln -s /etc/nginx/sites-available/michalkcare.conf /etc/nginx/sites-enabled/
 sudo nginx -t
 sudo systemctl reload nginx

 # 5. Obter certificado SSL (APÓS DNS propagado!)
 sudo certbot --nginx -d michalkcare.com -d www.michalkcare.com

 Nginx config inicial (HTTP apenas - para obter SSL):
 server {
     listen 80;
     server_name michalkcare.com www.michalkcare.com;
     root /var/www/michalkcare/dist;
     index index.html;

     location / {
         try_files $uri $uri/ =404;
     }
 }

 Fase 4: Build e Deploy (15 min)

 Na máquina local (/home/edson/dev/clinica-website):
 # Build do projeto
 npm ci
 npm run build

 # Deploy via rsync
 rsync -avz --delete dist/ edson@187.95.108.109:/var/www/michalkcare/dist/

 Verificar no servidor:
 ssh edson@187.95.108.109
 ls -la /var/www/michalkcare/dist/
 sudo nginx -t && sudo systemctl reload nginx

 Fase 5: Verificação de Compliance Meta (10 min)

 Checklist obrigatório para aprovação:

 - Header: Logo visível
 - Body: Botão/Link WhatsApp funcional (CTA)
 - Footer com dados exatos do Meta Business Manager:
   - Razão Social (exatamente como cadastrado)
   - CNPJ (formato XX.XXX.XXX/XXXX-XX)
   - Endereço físico completo
 - HTTPS: Certificado válido (cadeado verde)
 - Responsivo: Funciona em mobile

 ---
 ARQUIVOS CRÍTICOS A MODIFICAR
 ┌──────────────────────┬─────────────────────────────────────────────────────────┐
 │       Arquivo        │                       Modificação                       │
 ├──────────────────────┼─────────────────────────────────────────────────────────┤
 │ src/data/clinic.json │ Atualizar com dados reais abaixo                        │
 ├──────────────────────┼─────────────────────────────────────────────────────────┤
 │ astro.config.mjs     │ SITE_URL → https://www.michalkcare.com                  │
 ├──────────────────────┼─────────────────────────────────────────────────────────┤
 │ public/robots.txt    │ Sitemap → https://www.michalkcare.com/sitemap-index.xml │
 ├──────────────────────┼─────────────────────────────────────────────────────────┤
 │ nginx/clinica.conf   │ server_name → www.michalkcare.com michalkcare.com       │
 ├──────────────────────┼─────────────────────────────────────────────────────────┤
 │ scripts/deploy.sh    │ REMOTE_HOST → IP do xeon_server                         │
 └──────────────────────┴─────────────────────────────────────────────────────────┘
 Alterações em src/data/clinic.json:

 {
   "name": "Clínica Dr. Edson Michalkiewicz",
   "legalName": "EDSON LUIZ MICHALKIEWICZ - CLINICA E SERVICOS MEDICOS EIRELI",
   "cnpj": "31.763.533/0001-59",
   "contact": {
     "phone": "3016-2003",
     "whatsapp": "+5544301620003",
     "whatsappDisplay": "(44) 3016-2003"
   },
   "address": {
     "street": "Rua Roberto Brzezinski, 2052",
     "neighborhood": "Centro",
     "city": "Campo Mourão",
     "state": "PR",
     "zip": "87302-200"
   },
   "siteUrl": "https://www.michalkcare.com"
 }

 ---

 ## VERIFICAÇÃO PÓS-DEPLOY

 ```bash
 # Testar HTTPS
 curl -I https://www.michalkcare.com

 # Verificar certificado SSL
 openssl s_client -connect www.michalkcare.com:443 -servername www.michalkcare.com

 # Testar redirect HTTP → HTTPS
 curl -I http://www.michalkcare.com

 # Testar redirect non-www → www
 curl -I https://michalkcare.com

 Ferramentas online:
 - SSL Labs: https://www.ssllabs.com/ssltest/
 - Meta Sharing Debugger: https://developers.facebook.com/tools/debug/

 ---
 ALTERNATIVAS DE EMERGÊNCIA

 Se DNS demorar a propagar (>4h):

 1. Usar Cloudflare (propagação em minutos)
 2. Configurar IP direto temporariamente no Meta

 Se servidor não estiver disponível:

 1. Deploy em Vercel/Netlify (grátis, 5 min)
 2. Usar GitHub Pages

 Se projeto completo der problema:

 1. Criar index.html mínimo com:
   - Logo
   - "Em breve"
   - WhatsApp link
   - Footer com dados corporativos

 ---
 RESUMO EXECUTIVO
 ┌───────────────────────────────────┬─────────────────────────────┬─────────────┐
 │               Etapa               │            Tempo            │ Responsável │
 ├───────────────────────────────────┼─────────────────────────────┼─────────────┤
 │ 1. Atualizar dados em clinic.json │ 15 min                      │ Dev         │
 ├───────────────────────────────────┼─────────────────────────────┼─────────────┤
 │ 2. Configurar DNS                 │ 30 min + propagação         │ Admin DNS   │
 ├───────────────────────────────────┼─────────────────────────────┼─────────────┤
 │ 3. Setup Nginx + SSL              │ 30 min                      │ SysAdmin    │
 ├───────────────────────────────────┼─────────────────────────────┼─────────────┤
 │ 4. Build + Deploy                 │ 15 min                      │ Dev         │
 ├───────────────────────────────────┼─────────────────────────────┼─────────────┤
 │ 5. Validação Meta                 │ 10 min                      │ Dev         │
 ├───────────────────────────────────┼─────────────────────────────┼─────────────┤
 │ TOTAL                             │ ~2 horas (+ propagação DNS) │             │
 └───────────────────────────────────┴─────────────────────────────┴─────────────┘
 ---
 DADOS CONFIRMADOS ✓
 ┌──────────────────────┬──────────────────────────────────────────────────────────────┐
 │        Campo         │              Valor Exato (para usar no Footer)               │
 ├──────────────────────┼──────────────────────────────────────────────────────────────┤
 │ Razão Social         │ EDSON LUIZ MICHALKIEWICZ - CLINICA E SERVICOS MEDICOS EIRELI │
 ├──────────────────────┼──────────────────────────────────────────────────────────────┤
 │ CNPJ                 │ 31.763.533/0001-59                                           │
 ├──────────────────────┼──────────────────────────────────────────────────────────────┤
 │ Endereço             │ Rua Roberto Brzezinski, 2052 - Campo Mourão, PR 87.302-200   │
 ├──────────────────────┼──────────────────────────────────────────────────────────────┤
 │ WhatsApp             │ +55 44 3016-2003                                             │
 ├──────────────────────┼──────────────────────────────────────────────────────────────┤
 │ WhatsApp (bloqueado) │ +55 44 3144-4560                                             │
 └──────────────────────┴──────────────────────────────────────────────────────────────┘
 ---
 INFORMAÇÕES DOS SERVIDORES ✓

 xeon_server (Site Público)
 ┌────────────┬────────────────────────────────────┐
 │    Info    │               Valor                │
 ├────────────┼────────────────────────────────────┤
 │ IP Público │ 187.95.108.109                     │
 ├────────────┼────────────────────────────────────┤
 │ Nginx      │ Instalado ✓                        │
 ├────────────┼────────────────────────────────────┤
 │ Certbot    │ Instalado ✓                        │
 ├────────────┼────────────────────────────────────┤
 │ Função     │ Site público para verificação Meta │
 └────────────┴────────────────────────────────────┘
 VPS Hostinger (n8n + Dados)
 ┌────────────┬──────────────────────────────────────┐
 │    Info    │                Valor                 │
 ├────────────┼──────────────────────────────────────┤
 │ IP Público │ 31.97.19.152                         │
 ├────────────┼──────────────────────────────────────┤
 │ Subdomínio │ n8n.michalkcare.com                  │
 ├────────────┼──────────────────────────────────────┤
 │ Proteção   │ Tailscale VPN                        │
 ├────────────┼──────────────────────────────────────┤
 │ Função     │ n8n, banco de dados, dados sensíveis │
 ├────────────┼──────────────────────────────────────┤
 │ Status     │ ✓ Não será afetado pelas mudanças    │
 └────────────┴──────────────────────────────────────┘
 Instalação do Certbot (recomendado):

 # Instalar via snap (versão oficial recomendada pela Let's Encrypt)
 sudo snap install --classic certbot
 sudo ln -s /snap/bin/certbot /usr/bin/certbot