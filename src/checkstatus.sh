#!/bin/sh

# Waits until the postgres service accepts connections.

 

DB_HOST="${DB_HOST:-postgres}"

DB_PORT="${DB_PORT:-5432}"

 

echo "Waiting for PostgreSQL at ${DB_HOST}:${DB_PORT}..."

 

until pg_isready -h "$DB_HOST" -p "$DB_PORT" -q; do

  echo "PostgreSQL is not ready yet, checking again in 2 seconds..."

  sleep 2

done

 

echo "PostgreSQL is ready to accept connections."

exit 0

