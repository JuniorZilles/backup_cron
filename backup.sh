#!/bin/sh
echo "Inicio da Execução do know_hosts_add"
eval $(ssh-agent -s)

bash -c 'ssh-add <(echo "$SSH_PRIVATE_KEY")'

mkdir -p ~/.ssh

echo "$SSH_KNOWN_HOSTS" > ~/.ssh/known_hosts

echo "Inicio da Execução do Backup"
date_now=$(date +%Y%m%d-%H%M)
path=$(pwd)
echo "Criando diretório"
if [ ! -d "$caminho" ]; then
    mkdir pg-backup
else
    echo "Diretório já existe!"
fi

echo "Gerando o dump" + $PG_DBNAME_1

pg_dump postgres://$PG_USER:$PG_PASS@$PG_HOST:$PG_PORT/$PG_DBNAME_1 -f pg-backup/$PG_DBNAME_1-$date_now.dump

echo "Gerando o dump" + $PG_DBNAME_2

pg_dump postgres://$PG_USER:$PG_PASS@$PG_HOST:$PG_PORT/$PG_DBNAME_2 -f pg-backup/$PG_DBNAME_2-$date_now.dump

echo "Gerando o .tar.gz"
file_name="pg-backup-"$date_now".tar.gz"
tar -zcvf $file_name pg-backup

echo "Verificando se tem conteúdo no arquivo gerado"
filesize=$(stat -c %s $file_name)
mfs=10
if [[ "$filesize" -gt "$mfs" ]]; then
echo "Salvar o arquivo no outro servidor"
ssh-keyscan -H 192.168.56.102 >> ~/.ssh/known_hosts
sshpass -p "secret" scp $file_name stack@192.168.56.102:/home/stack/
echo "Dump salvo"
fi
