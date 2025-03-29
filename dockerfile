FROM alpine:latest

RUN apk update && \
    apk add gnupg curl dnsdist

COPY dnsdist.conf /etc/dnsdist.conf

EXPOSE 53/udp 53/tcp
VOLUME ["/etc/dnsdist/"]

ENTRYPOINT ["/usr/bin/dnsdist", "--supervised"]
