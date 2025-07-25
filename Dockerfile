FROM cm2network/steamcmd:latest

USER root
RUN apt-get update && apt-get install -y gosu

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 7777/udp 27015/udp

ENTRYPOINT ["/entrypoint.sh"]
