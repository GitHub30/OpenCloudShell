#!/bin/bash
# ?arg=port=2222&arg=destination=linuxserver.io@localhost&arg=key=$(cat dummy.key)
echo "SSH Wrapper Script Starting..."
ssh_opts=()
ssh_opts+=(-o ConnectTimeout=5)
ssh_opts+=(-o StrictHostKeyChecking=no)

for param in "$@"; do
    case $param in
        port=*)
            ssh_opts+=(-p "${param#*=}")
        ;;
        key=*)
            echo "Received key parameter, writing to temporary file..."
            TMP_KEY=$(mktemp)
            echo "${param#*=}" > "$TMP_KEY"
            chmod 600 "$TMP_KEY"
            ssh_opts+=(-i "$TMP_KEY")
        ;;
        destination=*)
            destination="${param#*=}"
        ;;
    esac
done

exec ssh "${ssh_opts[@]}" "$destination"
