2026-02-11

Criado o xeonserver_bot no telegram para receber alertas do servidor

token e chatID: no splashID

---

2026-08-27 — health_check.sh versionado no repo

- O emissor do bot é `scripts/health_check.sh` (cópia fiel do que roda no servidor em
  `/home/edson/scripts/health_check.sh`). Até hoje ele só existia na máquina — se o Xeon
  morresse, o script morria junto.
- **Como roda no servidor:** cron do **root**, a cada 6 horas
  (`0 */6 * * * /home/edson/scripts/health_check.sh >> /var/log/health_check.log 2>&1`).
- **Credenciais no servidor:** `/etc/xeon-secrets.env` (o script faz `source` de lá;
  nada de token no repo).
- O que ele faz: checa nginx, cloudflared, fail2ban e ssh (**reinicia sozinho** o que
  estiver caído), disco >80% e UFW, e manda o relatório pelo `xeonserver_bot` — inclusive
  o "🟢 Tudo OK" a cada ciclo.
- **Deploy de mudança:** editar aqui → `scp scripts/health_check.sh xeon:scripts/` →
  o cron pega na próxima execução.
- Pendente (fila diferida 2026-08-26): reduzir o ruído — só enviar mensagem própria quando
  houver problema, e o "tudo OK" passar a viver no digest consolidado do supervisor
  Infra-Saúde (dell_server, Fase 1).

