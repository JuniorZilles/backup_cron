#!/bin/bash

cd /home/root
date_now=$(date +%Y%m%d-%H%M)
mkdir pg-backup

#PGPASSWORD_1=pg_dump -h 192.168.56.101 vpn-db -p 30008 -U postgres > pg-backup/vpn-db-"$date_now".dump
PGPASSWORD_1=pg_dump --dbname=postgres://postgres:postgres@192.168.56.101:30008/vpn-db -f pg-backup/vpn-db-"$date_now".dump

#PGPASSWORD_2="$PG_PASS" pg_dump -h 192.168.56.101 "$PG_DBNAME_2" -p "$PG_PORT" -U "$PG_USER" > pg-backup/"$PG_DBNAME_2"-"$date_now".dump

file_name="pg-backup-"$date_now".tar.gz"
#Compressing backup file for upload
tar -zcvf $file_name pg-backup

filesize=$(stat -c %s $file_name)
mfs=10
if [[ "$filesize" -gt "$mfs" ]]; then
PGPASSWORD_1=secret scp $file_name stack@192.168.56.102:/home/stack
echo "Dump salvo"
fi