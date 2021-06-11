# This is based on jaysonsantos/docker-minecraft-ftb-skyfactory3

FROM java:8

MAINTAINER MegaThorx <git@merx.dev>

ENV VERSION=4.2.2

RUN apt-get update && apt-get install -y wget unzip
RUN addgroup --gid 1234 minecraft
RUN adduser --disabled-password --home=/data --uid 1234 --gid 1234 --gecos "minecraft user" minecraft

RUN mkdir /tmp/feed-the-beast && cd /tmp/feed-the-beast && \
	wget -c https://media.forgecdn.net/files/3012/800/SkyFactory-4_Server_${VERSION}.zip -O SkyFactory4.zip && \
	unzip SkyFactory4.zip && \
	rm SkyFactory4.zip && \
	bash -x Install.sh && \
	chown -R minecraft /tmp/feed-the-beast


USER minecraft

EXPOSE 25565

ADD start.sh /start

VOLUME /data
ADD server.properties /tmp/server.properties
WORKDIR /data

CMD /start

ENV MOTD A Minecraft (FTB SkyFactory 4 ${VERSION}) Server Powered by Docker
ENV LEVEL world
ENV JVM_OPTS -Xms2048m -Xmx2048m
