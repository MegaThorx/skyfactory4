FROM openjdk:alpine

MAINTAINER MegaThorx <git@merx.dev>

ENV VERSION=4.2.2

RUN apk update && apk add curl wget && \
    adduser -D -h /minecraft -u 1000 minecraft && \
	mkdir /minecraft/template && mkdir /minecraft/server && cd /minecraft/template && \
	wget -c https://media.forgecdn.net/files/3012/800/SkyFactory-4_Server_${VERSION}.zip -O SkyFactory4.zip && \
	unzip SkyFactory4.zip && \
	rm SkyFactory4.zip && \
	sh Install.sh && \
	chown -R minecraft /minecraft

ADD start.sh /minecraft/start.sh
RUN chown minecraft /minecraft/start.sh

USER minecraft
EXPOSE 25565

VOLUME /minecraft
ADD server.properties /minecraft/server.properties
WORKDIR /minecraft

CMD /bin/sh start.sh

ENV MOTD A Minecraft (FTB SkyFactory 4 ${VERSION}) Server Powered by Docker
ENV LEVEL world
ENV JVM_OPTS -Xms4096m -Xmx8192m -XX:+UseG1GC -Dsun.rmi.dgc.server.gcInterval=2147483646 -XX:+UnlockExperimentalVMOptions -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32M -Dfml.readTimeout=180
