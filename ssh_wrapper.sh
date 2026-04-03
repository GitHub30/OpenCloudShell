#!/bin/bash

id="$1"
filename="/tmp/$id.json"

ssh_options=()

port=$(jq -r .port $filename 2> /dev/null)
if [ -n "$port" ]; then
    ssh_options+=(-p $port)
fi

password=$(jq -r .password $filename 2> /dev/null)
if [ -n "$password" ]; then
    TMP_PASS=$(mktemp)
    echo "$password" > $TMP_PASS
    sshpass_command="sshpass -f $TMP_PASS"
fi

key=$(jq -r .key $filename 2> /dev/null)
if [ -n "$key" ]; then
    TMP_KEY=$(mktemp)
    echo "$key" > $TMP_KEY
    chmod 600 "$TMP_KEY"
    ssh_options+=(-i $TMP_KEY)
fi


destination=$(jq -r .destination $filename 2> /dev/null)

exec $sshpass_command ssh -o ConnectTimeout=5 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "${ssh_options[@]}" "$destination"
