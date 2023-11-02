#!/bin/bash

# get current script dirname
SCRIPT_DIR="$(dirname "$0")"

# Cehck config.yml
CONFIG_FILE="$SCRIPT_DIR/config.yml"
if [ ! -f "$CONFIG_FILE" ]; then
  echo "Error: config.yml file does not exist. Please create the config.yml file with your TOKEN and CHAT_ID values."
  exit 1
fi

# load from config.yml
TOKEN=$(grep 'token:' "$CONFIG_FILE" | awk '{print $2}')
CHAT_ID=$(grep 'chat_id:' "$CONFIG_FILE" | awk '{print $2}')

# load last ip
if [ -f $SCRIPT_DIR/last_ip.txt ]; then
  LAST_IP=$(cat $SCRIPT_DIR/last_ip.txt)
else
  LAST_IP=""
fi

# load current ip
IP=$(curl -s https://ipinfo.io/ip)

# check current ip and last ip
if [ "$IP" != "$LAST_IP" ]; then
  # set the tg message
  MESSAGE="My public IP address has changed to $IP"

  # send to Telegram Bot API
  curl -s -X POST https://api.telegram.org/bot$TOKEN/sendMessage -d chat_id=$CHAT_ID -d text="$MESSAGE"

  # save current ip as last ip
  echo "$IP" > $SCRIPT_DIR/last_ip.txt
fi
    