#!/bin/bash

# set cwd to project root
cd "${0%/*}/.."

export PGHOST=raspberrypi.local
export PGPASSWORD=password

pg_dump -h $PGHOST -U postgres -d metabase > data/backup/pgdump_metabase.sql
pg_dump -h $PGHOST -U postgres -d babydata > data/backup/pgdump_babydata.sql
