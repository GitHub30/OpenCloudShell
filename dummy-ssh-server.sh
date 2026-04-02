if [ ! -f dummy.key ]; then
    ssh-keygen -t ed25519 -f dummy.key -q -N ""
    chmod 600 dummy.key
fi
# if not use 10022 port. then docker run
if ! docker ps --format '{{.Ports}}' | grep -q 10022; then
    docker run -d -p 10022:2222 -e PUBLIC_KEY="$(cat dummy.key.pub)" linuxserver/openssh-server
fi

# ssh -o StrictHostKeyChecking=no -i dummy.key -p 10022 linuxserver.io@localhost