#!/bin/bash

host=$(echo $1 | cut -d: -f1)
port=$(echo $1 | cut -d: -f2)
shift
command="$@"

echo "Aguardando o Cassandra ($host:$port) iniciar..."
while ! timeout 1 bash -c "echo > /dev/tcp/$host/$port" 2>/dev/null; do
    sleep 2
done

echo "Cassandra está pronto! Iniciando a interface Web..."
exec $command