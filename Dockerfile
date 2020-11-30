FROM alpine:latest
LABEL maintainer="Balen Mars <balen.mars@gmail.com>"
LABEL description="An alpine with the latest on Consul"

ENV CONSUL_V=1.9.0
ENV CONSUL_SHA256=409b964f9cec93ba4aa3f767fe3a57e14160d86ffab63c3697d188ba29d247ce

RUN apk add --update ca-certificates wget && \
    wget -O consul.zip https://releases.hashicorp.com/consul/${CONSUL_V}/consul_${CONSUL_V}_linux_amd64.zip && \
    echo "${CONSUL_SHA256} *consul.zip" | sha256sum -c - && \
    unzip consul.zip && \
    mv consul /bin && \
    rm -rf consul.zip && \
    rm -rf /tmp/* /var/cache/apk/*

EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 8500 8600 8600/udp

VOLUME [ "/data" ]

ENTRYPOINT [ "/bin/consul" ]
CMD [ "agen", "-data-dir", "/data", "-server", "-bootstrap-expect", "1", "-client=0.0.0.0" ]
