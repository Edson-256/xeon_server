#!/bin/bash
# Health Check + Telegram Alerts - Xeon Server
source /etc/xeon-secrets.env

DATE=$(date "+%Y-%m-%d %H:%M:%S")
PROBLEMS=""
REPORT=""

check_service() {
  if systemctl is-active --quiet $1; then
    REPORT="${REPORT}\n✅ $1"
  else
    REPORT="${REPORT}\n🔴 $1 DOWN - reiniciando..."
    PROBLEMS="${PROBLEMS}$1 "
    sudo systemctl restart $1
  fi
}

check_service nginx
check_service cloudflared
check_service fail2ban
check_service ssh

# Disco
DISK=$(df / | tail -1 | awk "{print \$5}" | tr -d "%")
if [ $DISK -gt 80 ]; then
  REPORT="${REPORT}\n⚠️ Disco: ${DISK}%"
  PROBLEMS="${PROBLEMS}disco "
else
  REPORT="${REPORT}\n✅ Disco: ${DISK}%"
fi

# UFW
if sudo ufw status | grep -q "active"; then
  REPORT="${REPORT}\n✅ UFW ativo"
else
  REPORT="${REPORT}\n🔴 UFW inativo!"
  PROBLEMS="${PROBLEMS}ufw "
fi

# Envia mensagem
HEADER="🖥️ *Xeon Server* | ${DATE}"
if [ -n "$PROBLEMS" ]; then
  MSG="${HEADER}\n⚠️ *ALERTA*: ${PROBLEMS}\n${REPORT}"
else
  MSG="${HEADER}\n🟢 Tudo OK\n${REPORT}"
fi

curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
  -d chat_id="${TELEGRAM_CHAT_ID}" \
  -d text="$(echo -e "$MSG")" \
  -d parse_mode="Markdown" > /dev/null 2>&1

echo -e "[$DATE] $MSG"
