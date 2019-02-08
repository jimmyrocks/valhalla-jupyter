#!/bin/bash

# Install the database for osm2pgsql
if [ "`whoami`" == "root" ]; then

  # Set up the rendering Database
  psql -U postgres -d postgres -c "CREATE USER $PGUSER WITH PASSWORD '$PGPASSWORD' SUPERUSER;"
  psql -U postgres -d postgres -c "CREATE DATABASE $PGDATABASE;"
  psql -U postgres -d postgres -c "GRANT ALL PRIVILEGES ON DATABASE $PGDATABASE to $PGUSER;"

  psql -U $PGUSER -d $PGDATABASE -c "CREATE EXTENSION postgis;"
  psql -U $PGUSER -d $PGDATABASE -c "CREATE EXTENSION postgis_topology;"
  psql -U $PGUSER -d $PGDATABASE -c "CREATE EXTENSION hstore;"

  osm2pgsql \
    --slim \
    --create \
    --username $PGUSER \
    --database $PGDATABASE \
    --host $PGHOST \
    --port $PGPORT \
    $VALHALLA_DATA
    


fi
