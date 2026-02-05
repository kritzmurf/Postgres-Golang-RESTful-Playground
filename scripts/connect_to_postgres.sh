#!/bin/bash

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
source "$SCRIPT_DIR/includes/load_configuration.sh"

#Load Environment Vars
load_configuration POSTGRES_NAME POSTGRES_USER

docker exec -it  $POSTGRES_NAME psql -U $POSTGRES_USER
