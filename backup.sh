#!/bin/sh
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
sshpass -p "secret" scp -r stack@192.168.56.101:/home/stack $path/$file_name
echo "Dump salvo"
fi
