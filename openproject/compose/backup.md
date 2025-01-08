on DO cloud
- Install as DEB/RPM packages
- Data volumes:
   - /etc/openproject : config

   sudo --login --user=postgres
psql -h localhost -d openrealdb -U open_real -p 5432

su - postgres

CREATE DATABASE openrealdb;
CREATE USER open_real WITH PASSWORD 'p4ssw0rd';
GRANT ALL PRIVILEGES ON DATABASE openrealdb TO open_real;

# pg_dump -h localhost -d openrealdb -U open_real -p 54313 > op_backup.sql

pg_restore --clean --if-exists --dbname \$(sudo openproject config:get DATABASE_URL) /tmp/postgresql-dump-20241230103138.pgdump
# dos2unix backup_op_do_to_local.sh  

# docker cp ./local_backup_op/op_backup.sql openproject-db-1:/tmp/op_backup.sql

# psql -U openproject -h 127.0.0.1 -p 5432 -d openproject -f /tmp/op_backup.sql

# psql -h localhost -d openrealdb -U open_real -p 5432 < /tmp/ostgresql-dump-20241230103138.pgdump

 | 2024-12-27 09:26:13.922 UTC [241] ERROR:  relation "good_jobs" does not exist at character 523
db-1        | 2024-12-27 09:26:13.922 UTC [241] STATEMENT:  SELECT a.attname, format_type(a.atttypid, a.atttypmod),
db-1        |          pg_get_expr(d.adbin, d.adrelid), a.attnotnull, a.atttypid, a.atttypmod,
db-1        |          c.collname, col_description(a.attrelid, a.attnum) AS comment,
db-1        |          attidentity AS identity,
db-1        |          attgenerated as attgenerated
db-1        |     FROM pg_attribute a
db-1        |     LEFT JOIN pg_attrdef d ON a.attrelid = d.adrelid AND a.attnum = d.adnum
db-1        |     LEFT JOIN pg_type t ON a.atttypid = t.oid
db-1        |     LEFT JOIN pg_collation c ON a.attcollation = c.oid AND a.attcollation <> t.typcollation
db-1        |    WHERE a.attrelid = '"good_jobs"'::regclass
db-1        |      AND a.attnum > 0 AND NOT a.attisdropped
db-1        |    ORDER BY a.attnum



sudo tar xzf backup/attachments-20241230103138.tar.gz -C op/assets/files

sudo tar xzf backup/conf-20241230103138.tar.gz -C op/assets 
docker cp backup/postgresql-dump-20241230103138.pgdump compose-db-1:/tmp/ 
sudo chown -R 1000:1000 backup/postgresql-dump-20241230103138.pgdump 

pg_restore -h localhost -d openrealdb -U open_real -p 5432 /tmp/postgresql-dump-20241230103138.pgdump

 DROP SCHEMA IF EXISTS open_real;
pg_restore: error: could not execute query: ERROR:  schema "open_real" already exists
Command was: CREATE SCHEMA open_real;


pg_restore -h localhost -U open_real -p 5432 --clean --if-exists --dbname=openrealdb /tmp/postgresql-dump-20241230103138.pgdump

 psql -h localhost -U open_real -p 5432 -d openrealdb -c "DROP SCHEMA IF EXISTS open_real CASCADE;"