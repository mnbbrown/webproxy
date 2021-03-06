FROM gliderlabs/alpine

ENV CONSUL_TEMPLATE_VERSION=0.12.1
RUN apk-install bash haproxy ca-certificates

ADD https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip /
RUN unzip consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip && \
    mv consul-template /usr/local/bin/consul-template && \
    rm -rf /consul_template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip && \
    rm -rf /consul_template_${CONSUL_TEMPLATE_VERSION}_linux_amd64


RUN mkdir -p /etc/consul-template
ADD haproxy.conf.tmpl /etc/consul-template/template.d/haproxy.tmpl
ADD consul-template.cfg /etc/consul-template/consul-template.cfg

EXPOSE 80
EXPOSE 443
EXPOSE 9000

ADD start.sh /bin/start.sh
ENTRYPOINT ["/bin/start.sh"]
