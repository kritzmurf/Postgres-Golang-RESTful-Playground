#!/bin/bash

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
source "$SCRIPT_DIR/includes/load_configuration.sh"

#Load Environment Vars
load_configuration POSTGRES_NAME POSTGRES_PASSWD POSTGRES_PORT POSTGRES_IMG_NAME

#create or start docker image
if [ "$(docker ps -aq -f name=^/${POSTGRES_NAME})" ]; then
    echo "Starting Container: '$POSTGRES_NAME'"
    docker start $POSTGRES_NAME
else
    echo "Container: '$POSTGRES_NAME' has not been created. Creating..."
    docker run --name $POSTGRES_NAME \
        -e POSTGRES_PASSWORD=$POSTGRES_PASSWD \
        -p $POSTGRES_PORT \
        -d $POSTGRES_IMG_NAME
fi
