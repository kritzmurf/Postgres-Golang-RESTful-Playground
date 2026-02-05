#!/bin/bash

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
source "$SCRIPT_DIR/includes/load_configuration.sh"

#Load Environment Vars
load_configuration POSTGRES_NAME

docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $POSTGRES_NAME 
