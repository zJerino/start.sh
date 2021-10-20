#!/bin/bash

DIR="$(dirname "$(readlink -f "$0")")";
cd $DIR;

# Server Configuration
SERVER_NAME="Lobby";
SERVER_PORT=25565;
SERVER_RAM=1G;
SERVER_SCRIPT="spigot.jar"

# Webhook Configuration
WEBHOOK_ENABLE = false
WEBHOOK_URL="https://discord.com/api/webhooks/897726832353349643/ARTlO1jkA0LyZYmfZ9qEz1RaOexZh0Heoe2UeF1UVyu1f42bAvJUrDU62_YbrJG100gb";
WEBHOOK_COLOR_SUCESS = 5763719;
WEBHOOK_COLOR_WARNING = 15105570;
WEBHOOK_COLOR_DANGER = 15158332;

sleep 1s

while true; do
    echo "+---------------------------------------------------+"
    echo " [$SERVER_NAME] Iniciando."
    echo "+---------------------------------------------------+"

    if $WEBHOOK_ENABLE; then
        curl -d "{\"embeds\": [{\"title\": \"Intentando iniciar servidor: $SERVER_NAME\", \"color\": $WEBHOOK_COLOR_SUCESS}]}" -H "Content-Type: application/json" -X POST $WEBHOOK_URL
    fi;

    java -Xmx$SERVER_RAM -Dfile.encoding=UTF-8 -jar $SERVER_SCRIPT --port $SERVER_PORT

    sleep 5s
    
    echo "+---------------------------------------------------+"
    echo " [$SERVER_NAME] Detenido."
    echo "+---------------------------------------------------+"

    if $WEBHOOK_ENABLE; then
        curl -d "{\"embeds\": [{\"title\": \"El servidor [$SERVER_NAME] ha detenido\", \"color\": $WEBHOOK_COLOR_DANGER}]}" -H "Content-Type: application/json" -X POST $WEBHOOK_URL
    fi;
    
    sleep 5s
    echo "+---------------------------------------------------+"
    echo " [$SERVER_NAME] Reiniciando."
    echo "+---------------------------------------------------+"
    
    if $WEBHOOK_ENABLE; then
        curl -d "{\"embeds\": [{\"title\": \"Reiniciando el servidor: $SERVER_NAME\", \"color\": $WEBHOOK_COLOR_WARNING}]}" -H "Content-Type: application/json" -X POST $WEBHOOK_URL
    fi;
done
