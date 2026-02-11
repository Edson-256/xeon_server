# Guia de Deploy Rápido: Michalk Care

Este guia descreve os passos exatos para colocar o site no ar no servidor Ubuntu (Xeon).

## Pré-requisitos
- Acesso SSH ao servidor Ubuntu (`ssh seu-usuario@ip-do-servidor`).
- Domínio `michalkcare.com` comprado.

## Passo 1: Configurar DNS (No Registro.br ou Cloudflare)
Aponte o domínio para o IP do seu servidor Xeon.
- **Tipo**: A
- **Nome**: @ (ou deixe em branco)
- **Valor**: `[SEU.IP.PUBLICO]` (Ex: 200.x.x.x)

- **Tipo**: CNAME
- **Nome**: www
- **Valor**: michalkcare.com

> **Nota**: Se usar Cloudflare, deixe a "nuvem laranja" ativada para SSL automático, mas ainda precisaremos configurar o Nginx.

## Passo 2: Preparar o Servidor
Execute estes comandos no terminal do servidor:

1. **Instalar Nginx** (se ainda não tiver):
   ```bash
   sudo apt update
   sudo apt install nginx -y
   ```

2. **Criar diretórios**:
   ```bash
   sudo mkdir -p /var/www/michalkcare/public_html
   sudo chown -R $USER:$USER /var/www/michalkcare
   ```

3. **Copiar arquivos (Do seu PC para o Servidor)**:
   *No seu computador (não no servidor), execute:*
   ```bash
   rsync -avz ./public_html/ index.html usuario@ip-servidor:/var/www/michalkcare/public_html/
   rsync -avz ./nginx/michalkcare.conf usuario@ip-servidor:/etc/nginx/sites-available/
   ```

4. **Ativar o Site**:
   *De volta no servidor:*
   ```bash
   sudo ln -s /etc/nginx/sites-available/michalkcare.conf /etc/nginx/sites-enabled/
   sudo nginx -t
   sudo systemctl reload nginx
   ```

## Passo 3: Configurar SSL (HTTPS)
A Meta EXIGE HTTPS. Usaremos o Certbot.

1. **Instalar Certbot**:
   ```bash
   sudo apt install certbot python3-certbot-nginx -y
   ```

2. **Gerar Certificado**:
   ```bash
   sudo certbot --nginx -d michalkcare.com -d www.michalkcare.com
   ```
   - Siga as instruções na tela.
   - Escolha "Redirect" (2) se perguntado, para forçar HTTPS.

## Passo 4: Verificação Final
1. Acesse `https://www.michalkcare.com` no navegador.
2. Verifique se o cadeado (SSL) aparece.
3. Verifique se o **CNPJ** e **Endereço** no rodapé estão corretos.

✅ **Pronto!** Agora você pode submeter o site para a Meta.
