#!/bin/bash

id="$1"
filename="/tmp/$id.json"

port=$(jq -r .port "$filename")
destination=$(jq -r .destination "$filename")

TMP_KEY=$(mktemp)
key=$(jq -r '.key' "$filename")
echo "$key" > "$TMP_KEY"
chmod 600 "$TMP_KEY"

exec ssh -o ConnectTimeout=5 -o StrictHostKeyChecking=no -p "$port" -i "$TMP_KEY" "$destination"
