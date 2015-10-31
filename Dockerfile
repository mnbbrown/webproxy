FROM gliderlabs/alpine

ENV CONSUL_TEMPLATE_VERSION=0.11.0
RUN apk-install bash haproxy ca-certificates

ADD https://github.com/hashicorp/consul-template/releases/download/v${CONSUL_TEMPLATE_VERSION}/consul_template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip /
RUN unzip consul_template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip && \
    mv consul-template /usr/local/bin/consul-template && \
    rm -rf /consul_template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip && \
    rm -rf /consul_template_${CONSUL_TEMPLATE_VERSION}_linux_amd64


RUN mkdir -p /etc/consul-template
ADD haproxy.conf.tmpl /etc/consul-template/template.d/haproxy.tmpl
ADD consul-template.cfg /etc/consul-template/consul-template.cfg

EXPOSE 80
EXPOSE 443

ADD start.sh /bin/start.sh
ENTRYPOINT ["/bin/start.sh"]
