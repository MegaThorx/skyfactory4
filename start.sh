#!/bin/sh

cd /minecraft/server

cp -rf /minecraft/template/* .

if [[ ! -e server.properties ]]; then
    cp /minecraft/server.properties .
fi

if [[ -n "$MOTD" ]]; then
    sed -i "/motd\s*=/ c motd=$MOTD" server.properties
fi

if [[ -n "$LEVEL" ]]; then
    sed -i "/level-name\s*=/ c level-name=$LEVEL" server.properties
fi

if [[ -n "$OPS" ]]; then
    echo $OPS | awk -v RS=, '{print}' >> ops.txt
fi

. ./settings.sh

java -server $JVM_OPTS -jar ${SERVER_JAR} nogui
