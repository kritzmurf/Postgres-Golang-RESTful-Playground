#!/bin/bash

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
source "$SCRIPT_DIR/includes/load_configuration.sh"

#Load Environment Vars
load_configuration PGADMIN_NAME PGADMIN_PASSWD PGADMIN_PORT PGADMIN_EMAIL PGADMIN_IMG_NAME

if [ "$(docker ps -aq -f name=^/${PGADMIN_NAME})" ]; then
    echo "Starting Container: '$PGADMIN_NAME'"
    docker start $PGADMIN_NAME
else
    echo "Container: '$PGADMIN_NAME' has not been created. Creating..."

    docker run --name $PGADMIN_NAME \
        -p $PGADMIN_PORT \
        -e PGADMIN_DEFAULT_EMAIL=$PGADMIN_EMAIL \
        -e PGADMIN_DEFAULT_PASSWORD=$PGADMIN_PASSWD \
        -d $PGADMIN_IMG_NAME 
fi
