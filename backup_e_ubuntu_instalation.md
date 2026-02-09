Entendido. Como o servidor está em um rack e sem periféricos, o maior desafio é a transição entre o acesso via RDP (Remote Desktop) e o terminal (SSH).

Um detalhe crítico: **A instalação do Ubuntu Server exige, obrigatoriamente, um monitor e teclado conectados ao rack (pelo menos uma vez)** para configurar a rede e o SSH, a menos que seu servidor tenha uma placa de gerenciamento remoto (como Dell iDRAC ou HP iLO). Se não tiver, você precisará levar um monitor e teclado até o rack para o **Passo 3**.

Aqui está o plano de ação:

---

## Passo 1: Backup dos Arquivos (Via Mac/iTerm2)

Em vez de usar a interface gráfica, vamos usar o protocolo SMB (que o Windows já usa para compartilhar arquivos) para puxar os dados para o seu Mac.

1. **No Windows Server (via RDP):**
* Garanta que a pasta de arquivos esteja compartilhada na rede.
* Anote o IP do servidor (192.168.100.242).


2. **No Mac (iTerm2):**
* Crie uma pasta local para o backup: `mkdir ~/Backup_Servidor`.
* Use o comando `rsync` (mais seguro que o `cp` simples) para baixar os arquivos.
* *Dica:* No macOS, você pode montar a unidade de rede no Finder e depois rodar:


```bash
rsync -avP /Volumes/Pasta_Compartilhada/ ~/Backup_Servidor/

```



---

## Passo 2: Preparação da Mídia de Instalação

Como você não tem monitor no rack, precisamos que o instalador esteja pronto.

1. Baixe a ISO do **Ubuntu Server 24.04 LTS**.
2. Use o software **BalenaEtcher** (Mac/Windows) para gravar a ISO em um pendrive.
3. **Importante:** Se o seu servidor for muito antigo, verifique se ele suporta boot via UEFI ou apenas Legacy (BIOS). O X3430 costuma ser da era de transição; o modo "Legacy" é mais garantido para esse hardware.

---

## Passo 3: A Instalação (Momento "Mão na Massa")

Nesta etapa, você **precisará conectar um monitor e teclado temporariamente** ao servidor no rack.

1. Insira o pendrive e reinicie o servidor.
2. Acesse o Menu de Boot (geralmente `F11`, `F12` ou `ESC`) e selecione o pendrive.
3. Siga o instalador:
* **Idioma e Teclado:** Selecione sua preferência.
* **Rede:** Certifique-se de que ele obteve um IP via DHCP. **Anote este IP.**
* **Storage:** Selecione o disco rígido principal. *Atenção: Isso apagará o Windows Server.*
* **SSH Setup:** Marque a opção **"Install OpenSSH Server"**. Isso é vital para você nunca mais precisar de monitor no rack.



---

## Passo 4: Acesso Remoto e Configuração Web

Agora você já pode desconectar o monitor e voltar para o seu Mac.

1. **Acesso via iTerm2:**
```bash
ssh seu-usuario@ip-do-servidor

```


2. **Instalação do Servidor Web (Nginx):**
```bash
sudo apt update && sudo apt install nginx -y

```


3. **Testar o Site:**
Abra o navegador no seu Mac e digite o IP do servidor. Você verá a página "Welcome to nginx".

---

## Resumo de Comandos Pós-Instalação

| Objetivo | Comando no Ubuntu |
| --- | --- |
| Atualizar o sistema | `sudo apt update && sudo apt upgrade -y` |
| Ver temperatura/uso (estilo Gerenciador de Tarefas) | `sudo apt install htop && htop` |
| Criar pasta para o Site | `sudo mkdir -p /var/www/meusite` |
| Ver espaço em disco | `df -h` |

---

### Próximo Passo Sugerido

Você prefere que eu prepare um script para configurar o **Samba** no Ubuntu (para que ele volte a aparecer como uma pasta de rede no seu Windows/Mac) ou quer focar primeiro em como subir os **vídeos e textos** para o site?