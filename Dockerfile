FROM alpine:3.7

LABEL maintainer "https://github.com/shivarammysore"

ENV TCPDUMP_VERSION 4.9.2-r1

VOLUME  [ "/data" ]
RUN apk add --no-cache --update tcpdump==${TCPDUMP_VERSION} coreutils

ENTRYPOINT [ "/usr/sbin/tcpdump" ]
