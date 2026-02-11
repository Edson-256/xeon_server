# Xeon Server — Relatório de Administração

> **Última atualização**: 2026-02-11
> **Propósito**: Referência central para administração e manutenção do servidor Xeon.

---

## 1. Visão Geral

| Item | Valor |
|:-----|:------|
| **Hostname** | Xeon Server (Dell Inspiron 14) |
| **SO** | Ubuntu 24.04.3 LTS |
| **Kernel** | 6.8.0-100-generic |
| **IP Ethernet** | `192.168.100.242` |
| **IP Wi-Fi** | `192.168.100.115` (backup) |
| **Disco** | 98 GB total, ~84 GB livre (11% em uso) |
| **Domínio** | `michalkcare.com` / `www.michalkcare.com` |
| **Usuário admin** | `edson` |

---

## 2. Acesso SSH

```bash
ssh -p 2222 edson@192.168.100.242
```

| Configuração | Valor |
|:-------------|:------|
| Porta | `2222` (não é a padrão 22) |
| Autenticação | Chave RSA apenas (senha desabilitada) |
| Root login | Desabilitado |
| Usuários permitidos | `edson` |
| Config | `/etc/ssh/sshd_config` |
| Backup | `/etc/ssh/sshd_config.bak` |

---

## 3. Serviços Ativos

| Serviço | Função | Comando de status |
|:--------|:-------|:------------------|
| **nginx** | Servidor web (site clínico) | `systemctl status nginx` |
| **cloudflared** | Túnel Cloudflare (expõe o site) | `systemctl status cloudflared` |
| **fail2ban** | Anti-brute force SSH | `systemctl status fail2ban` |
| **ssh** | Acesso remoto | `systemctl status ssh` |
| **unattended-upgrades** | Patches automáticos | `systemctl status unattended-upgrades` |

---

## 4. Cloudflare Tunnel

| Item | Valor |
|:-----|:------|
| **Tunnel ID** | `5e8dc101-eb71-4950-b3d7-da9d1463c2af` |
| **Config** | `/etc/cloudflared/config.yml` |
| **Credenciais** | `/home/edson/.cloudflared/5e8dc101-...json` |
| **Systemd** | `/etc/systemd/system/cloudflared.service` |

### Regras de Ingress

```yaml
ingress:
  - hostname: michalkcare.com
    service: http://localhost:80
  - hostname: www.michalkcare.com
    service: http://localhost:80
  - service: http_status:404
```

> O tráfego da internet entra via Cloudflare → Tunnel seguro → Nginx local (porta 80).
> **Nenhuma porta é exposta diretamente à internet.**

---

## 5. Nginx

| Item | Valor |
|:-----|:------|
| **Sites ativos** | `default`, `michalkcare` |
| **Config do site** | `/etc/nginx/sites-available/michalkcare` |
| **Document root** | `/var/www/michalkcare/dist` |
| **Logs (access)** | `/var/log/nginx/michalkcare.access.log` |
| **Logs (error)** | `/var/log/nginx/michalkcare.error.log` |

### Headers de Segurança

- `X-Frame-Options: SAMEORIGIN`
- `X-Content-Type-Options: nosniff`
- `X-XSS-Protection: 1; mode=block`
- `Referrer-Policy: strict-origin-when-cross-origin`
- `Permissions-Policy: camera=(), microphone=(), geolocation=()`

### Comandos úteis

```bash
# Testar config antes de aplicar
sudo nginx -t

# Recarregar sem downtime
sudo systemctl reload nginx

# Ver headers
curl -sI -H "Host: michalkcare.com" http://localhost
```

---

## 6. Firewall (UFW)

```
Status: active  |  Default: deny incoming, allow outgoing

[1] Samba           ALLOW IN    Anywhere
[2] 2222/tcp        ALLOW IN    Anywhere          # SSH
[3] 80              ALLOW IN    127.0.0.1         # Nginx via Tunnel
[4] 80              ALLOW IN    192.168.100.0/24  # LAN Nginx
[5] 2222            ALLOW IN    192.168.100.0/24  # LAN SSH
```

```bash
# Ver status
sudo ufw status numbered

# Adicionar regra
sudo ufw allow from 192.168.100.0/24 to any port XXXX comment 'Descricao'

# Remover regra
sudo ufw delete NUMERO
```

---

## 7. Fail2Ban

| Item | Valor |
|:-----|:------|
| **Jail ativo** | `sshd` |
| **Porta monitorada** | `2222` |
| **Máx. tentativas** | 3 |
| **Tempo de ban** | 1 hora (3600s) |
| **Config** | `/etc/fail2ban/jail.local` |

```bash
# Ver status do jail SSH
sudo fail2ban-client status sshd

# Desbanir um IP
sudo fail2ban-client set sshd unbanip 1.2.3.4
```

---

## 8. Monitoramento Automático

### Health Check (Cron)

- **Script**: `/home/edson/scripts/health_check.sh`
- **Log**: `/var/log/health_check.log`
- **Frequência**: A cada 6 horas
- **Verifica**: nginx, cloudflared, fail2ban, ssh, disco (>80%), UFW

### Limpeza de Logs

- **Frequência**: Semanal (domingo 3h)
- **Ação**: Remove logs comprimidos com mais de 30 dias

```bash
# Ver cron jobs
sudo crontab -l

# Ver último health check
tail -20 /var/log/health_check.log
```

---

## 9. Estrutura de Diretórios

```
/var/www/
├── html/                    # Nginx default (pode ser removido)
└── michalkcare/
    └── dist/                # Site compilado (Astro) ← Document Root

/home/edson/
├── .cloudflared/            # Credenciais do Tunnel
├── .ssh/authorized_keys     # Chaves SSH autorizadas
└── scripts/
    └── health_check.sh      # Script de monitoramento

/etc/
├── nginx/sites-available/michalkcare  # Config Nginx
├── cloudflared/config.yml             # Config Tunnel
├── fail2ban/jail.local                # Config Fail2Ban
└── ssh/sshd_config                    # Config SSH
```

---

## 10. Deploy do Website

O site é construído com **Astro** (gerador estático). O desenvolvimento é feito em um repositório Git separado. Para deploy:

```bash
# 1. No ambiente de desenvolvimento, compilar o site:
npm run build

# 2. Copiar dist/ para o servidor:
scp -P 2222 -r dist/ edson@192.168.100.242:/var/www/michalkcare/

# 3. Verificar:
curl -sI -H "Host: michalkcare.com" http://localhost
```

---

## 11. Alertas via Telegram

| Item | Valor |
|:-----|:------|
| **Bot** | `@xeonserver_bot` |
| **Secrets** | `/etc/xeon-secrets.env` (chmod 600, root only) |
| **Frequência** | A cada 6 horas (cron) |
| **Mensagem OK** | 🟢 Tudo OK + status de cada serviço |
| **Mensagem ALERTA** | 🔴 Nome do serviço + tentativa de restart |

```bash
# Testar manualmente
sudo /home/edson/scripts/health_check.sh

# Editar token/chatID
sudo nano /etc/xeon-secrets.env
```

---

## 12. Comandos de Emergência

```bash
# Reiniciar todos os serviços
sudo systemctl restart nginx cloudflared fail2ban ssh

# Ver logs em tempo real
sudo journalctl -u cloudflared -f       # Tunnel
sudo tail -f /var/log/nginx/michalkcare.error.log  # Nginx

# Verificar se o site está respondendo
curl -sI https://michalkcare.com

# Reboot do servidor (aplica kernel pendente)
sudo reboot
```

---

## 12. DNS (Cloudflare)

| Registro | Tipo | Valor | Notas |
|:---------|:-----|:------|:------|
| `michalkcare.com` | CNAME | Gerenciado pelo Tunnel | Proxy ativado (☁️) |
| `www` | CNAME | Gerenciado pelo Tunnel | Proxy ativado (☁️) |
| `n8n` | A | `31.97.19.152` | VPS separada |
| MX/TXT | Vários | Google Workspace | Email corporativo |

**Nameservers**: `harvey.ns.cloudflare.com` / `maria.ns.cloudflare.com`
