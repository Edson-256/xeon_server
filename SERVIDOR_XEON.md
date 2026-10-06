# Xeon Server — Relatório de Administração

> **Última atualização**: 2026-02-11
> **Propósito**: Referência central para administração e manutenção do servidor Xeon.

---

## 1. Visão Geral

| Item | Valor |
|:-----|:------|
| **Hostname** | Xeon Server — servidor com **Intel Xeon X3430 @ 2.40GHz, placa Supermicro X8SIL** (medido por SSH em 2026-10-06; a versão anterior desta linha dizia "Dell Inspiron 14", que é o `dell_server`) |
| **SO** | Ubuntu 24.04.3 LTS |
| **Kernel** | 6.8.0-100-generic |
| **IP Ethernet** | `192.168.18.242` (estático, gw `.18.1`, migrado 2026-06 — ver `MUDANCA_IP_LAN_2026-06.md`) |
| **IP Wi-Fi** | (backup — IP `.18.x` a confirmar; antigo `192.168.100.115` obsoleto) |
| **Disco** | 98 GB total, ~84 GB livre (11% em uso) |
| **Domínio** | `michalkcare.com` / `www.michalkcare.com` |
| **Usuário admin** | `edson` |

---

## 2. Acesso SSH

```bash
ssh -p 2222 edson@192.168.18.242
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
  - hostname: codigo.michalkcare.com
    service: http://dell-server:80   # Tailscale MagicDNS (Dell) — imune a renumeração LAN. Migrado 2026-06 de 192.168.100.44.
  - service: http_status:404
```

> O tráfego da internet entra via Cloudflare → Tunnel seguro → Nginx local (porta 80).
> **Nenhuma porta é exposta diretamente à internet.**

### Servidores na Rede Local

| Hostname | IP | Serviço | URL |
|:---------|:---|:--------|:----|
| Xeon Server | 192.168.18.242 | Website clínico | michalkcare.com |
| Dell Server | 192.168.18.44 | CBHPM Code Advisor | codigo.michalkcare.com |

> O Dell Server é acessado via tunnel do Xeon (proxy reverso na mesma LAN).

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

## 5b. Rota `/musica` — guia de leitura do canal de música (desde 2026-09-04)

| Item | Valor |
|---|---|
| URL | `https://michalkcare.com/musica` |
| Pasta | `/var/www/musica/` (dono `edson`; **fora** de `/var/www/michalkcare/dist`, que o deploy do Astro sobrescreve) |
| Nginx | bloco `location /musica/ { alias /var/www/musica/; }` no vhost `michalkcare` (+ `301 /musica → /musica/`) |
| Origem | repo `~/dev/_pessoal/musica`: `./run.sh guia` gera `GUIA_LEITURA/site/index.html` e envia por `rsync` |
| Setup | `~/dev/_pessoal/musica/scripts/xeon_musica_setup.sh` (idempotente: `ssh xeon "bash -s" < …`) |

Página estática única (~420 KB), sem dependência de serviço. Se o vhost for recriado, rodar o setup de novo.

## 6. Firewall (UFW)

```
Status: active  |  Default: deny incoming, allow outgoing

[1] Samba           ALLOW IN    Anywhere
[2] 2222/tcp        ALLOW IN    Anywhere          # SSH
[3] 80              ALLOW IN    127.0.0.1         # Nginx via Tunnel
[4] 80              ALLOW IN    192.168.18.0/24  # LAN Nginx
[5] 2222            ALLOW IN    192.168.18.0/24  # LAN SSH
```

```bash
# Ver status
sudo ufw status numbered

# Adicionar regra
sudo ufw allow from 192.168.18.0/24 to any port XXXX comment 'Descricao'

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
scp -P 2222 -r dist/ edson@192.168.18.242:/var/www/michalkcare/

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
| `codigo` | CNAME | Gerenciado pelo Tunnel | CBHPM Code Advisor (Dell Server) |
| `n8n` | A | `31.97.19.152` | VPS separada |
| MX/TXT | Vários | Google Workspace | Email corporativo |

**Nameservers**: `harvey.ns.cloudflare.com` / `maria.ns.cloudflare.com`

---

## 13. Energia: no-break (registrado 2026-10-05)

Dados lidos da etiqueta traseira (fotos do Edson, 2026-10-05):

| Campo | Valor |
|:------|:------|
| Modelo | **NHS Premium Senoidal GII 2200VA** (senoidal pura, DSP) |
| Fabricação | **03/2013** |
| Número de série | 004928 (código `1191.C0.0220000004928`) |
| Potência | **2200 VA** (a etiqueta traseira não traz a potência em W) |
| Entrada | 120/220 V, seleção automática |
| Saída | **120 V** (reconfigurável 120/220 V — etiqueta "identificar se houver troca") |
| Banco de bateria | **72 Vcc** (6 baterias de 12 V em série, deduzido da tensão — não aberto) |
| Comunicação | **USB** ("Comunicação") + contatos secos NA1/NA2 (status bateria / status rede) — **não conectado a nenhum computador** em 2026-10-05 |
| Assistência local | Videotec Eletrônica — (44) 99122-9605 (adesivo no aparelho) |

- **Onde:** andar **térreo**, junto do roteador (Yoshiun).
- **Quem está ligado nele:** o Xeon Server e o **roteador** da clínica. É o nobreak que mantém
  a rede de pé numa queda de luz — sem ele, nenhuma máquina fica acessível por Tailscale.
- **Bateria:** a etiqueta manda trocar **em no máximo 5 anos ou quando o LED amarelo
  ("Atenção") acender direto**. A data da última troca de bateria é **desconhecida**
  (o aparelho é de 2013). Em 2026-10-05 o painel mostrava só **"Normal" aceso (azul)**,
  sem "Atenção" nem "Proteção".
- **Painel:** barras "Potência de saída" 20–100% indicam a carga atual.
- **Inventário dos outros no-breaks da clínica:** nota `Reference/Inventario-Nobreaks.md`
  no vault Obsidian.

### 13.1 Desligamento automático numa queda de luz (NUT, 2026-10-06 — `xeon_serve-cga`)

**Objetivo:** numa queda, o Xeon sai do no-break para deixar a bateria para o **roteador e o
switch** (que mantêm a internet e a rede da clínica, inclusive o Mac Studio no 2º andar).
O site `michalkcare.com` fica fora do ar durante a queda — aceito pelo Edson.

- **Conexão:** cabo USB NHS → Xeon. Aparece como `0925:1241` (Lakeview Research), porta
  serial **`/dev/ttyACM0`**. Protocolo que funciona: **`nutdrv_qx` com `protocol = megatec`**
  (testados e recusados: voltronic, mustek, bestups, zinto).
- **Regra:** em bateria (`OB`) → timer de **5 min** (`upssched`) → `upsmon -c fsd` → desligamento
  ordenado. Se a luz voltar antes (`OL`), o timer é cancelado. Bateria baixa (`LB`) desliga na hora.
- **Arquivos:** `/etc/nut/{nut,ups,upsd,upsd.users,upsmon,upssched}.conf` + `/usr/local/sbin/upssched-cmd`.
  Originais preservados como `*.orig`. Senha do usuário `upsmon` gerada aleatoriamente, só em
  `/etc/nut/upsd.users` e `upsmon.conf` (640, root:nut).
- **Serviços:** `nut-driver@nhs`, `nut-server`, `nut-monitor` (ativos e habilitados no boot).
- **Ver o estado:** `upsc nhs@localhost` (status `OL` = na rede, `OB` = bateria, `LB` = bateria baixa;
  `ups.load` em %, `battery.voltage` nominal 72 V). Leitura em 2026-10-06: carga **10%**,
  bateria 81,6 V (recarregando após a queda de 04/10).
- **Teste seguro (feito em 2026-10-06):** `touch /etc/nut/TEST_MODE` faz o `upssched-cmd` só
  registrar no log em vez de desligar; disparo e cancelamento do timer conferidos com
  `journalctl -t upssched-cmd`. **Nunca deixar `TEST_MODE` no lugar** — sem ele é o modo real.
- **⚠️ Religar depois da queda:** como o no-break continua ligado, o Xeon **fica desligado** quando a
  luz volta, até alguém ligá-lo. Ele aceita **Wake-on-LAN** (`enp5s0`, MAC `00:30:48:e4:2c:f8`,
  `Wake-on: g`). **Religação automática (2026-10-06, `xeon_serve-cg8`):** o Mac Studio manda
  Wake-on-LAN quando o Xeon some por 2 checagens (máx. 1 pacote/30 min) — ver
  `~/dev/studiom4/README.md` § Religar o Xeon. Se o Xeon ligar ainda em bateria, o serviço
  **`nut-boot-guard`** (`/usr/local/sbin/nut-boot-guard`, systemd) desliga de novo em 90 s.
  Para manutenção com o Xeon desligado de propósito: `touch ~/.xeon_wol_pause` no Studio.
