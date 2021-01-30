#!/bin/sh

date_now=$(date +%Y%m%d-%H%M)
mkdir pg-backup
#PGPASSWORD_1="$PG_PASS" pg_dump -h "$PG_HOST" "$PG_DBNAME_1" -p "$PG_PORT" -U "$PG_USER" > pg-backup/"$PG_DBNAME_1"-"$date_now".dump
pg_dump postgres://$PG_USER:$PG_PASS@$PG_HOST:$PG_PORT/$PG_DBNAME_1 -f pg-backup/$PG_DBNAME_1-$date_now.dump

#PGPASSWORD_2="$PG_PASS" pg_dump -h "$PG_HOST" "$PG_DBNAME_2" -p "$PG_PORT" -U "$PG_USER" > pg-backup/"$PG_DBNAME_2"-"$date_now".dump
#PGPASSWORD_2="$PG_PASS" pg_dump -h "$PG_HOST" "$PG_DBNAME_2" -p "$PG_PORT" -U "$PG_USER" > pg-backup/"$PG_DBNAME_2"-"$date_now".dump

file_name="pg-backup-"$date_now".tar.gz"
#Compressing backup file for upload
tar -zcvf $file_name pg-backup

filesize=$(stat -c %s $file_name)
mfs=10
if [[ "$filesize" -gt "$mfs" ]]; then
#scp $file_name stack@192.168.56.102
echo "Dump salvo"
fi
