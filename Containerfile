FROM alpine:latest

RUN mkdir -p /target
RUN touch /target/.notmounted

RUN mkdir -p /app

RUN apk add --no-cache curl

RUN curl -o /app/octavia-amphora-x64-haproxy-centos-9-stream.qcow2 \
        https://tarballs.opendev.org/openstack/octavia/test-images/test-only-amphora-x64-haproxy-centos-9-stream.qcow2
RUN cd /app/ && sha256sum *.qcow2 > /app/octavia-amphora-images.sha256sum

VOLUME /target

COPY script.sh /
RUN chmod 755 /script.sh

CMD ["/script.sh"]
