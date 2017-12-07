#!/bin/bash

docker-compose up -d
output=`docker port tornado_ahmes_postgres`
export PG_PORT="${output#*:}"

str="postgresql://postgres@localhost:${PG_PORT}/ahmes"
export AHMES_HOST="localhost"
export AHMES_USER="postgres"
export AHMES_PORT=$PG_PORT
export AHMES_DBNAME="ahmes"
export AHMES_PASSWORD=""
export PGSQL_AHMES="postgresql://postgres@localhost:${PG_PORT}/ahmes"

wait-for $str
prep-it
