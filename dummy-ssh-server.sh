if [ ! -f dummy.key ]; then
    ssh-keygen -t ed25519 -f dummy.key -q -N ""
    chmod 600 dummy.key
fi
# if not use 10022 port. then docker run
if ! docker ps --format '{{.Ports}}' | grep -q 10022; then
    docker run -d -p 10022:2222 -e SUDO_ACCESS=true -e PUBLIC_KEY="$(cat dummy.key.pub)" linuxserver/openssh-server
    # echo "export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '" >> ~/.profile
fi

# ssh -o LogLevel=ERROR -o StrictHostKeyChecking=no -i dummy.key -p 10022 linuxserver.io@localhost

# ssh -o LogLevel=ERROR -o StrictHostKeyChecking=no -p 443 -R0:localhost:10022 tcp@a.pinggy.io
# ssh -o LogLevel=ERROR -o StrictHostKeyChecking=no -i dummy.key -p 33567 linuxserver.io@ubxxe-23-97-62-139.run.pinggy-free.link