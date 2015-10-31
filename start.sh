#!/bin/bash
set -e
#set the DEBUG env variable to turn on debugging
[[ -n "$DEBUG" ]] && set -x

CONSUL_TEMPLATE=${CONSUL_TEMPLATE:-/usr/local/bin/consul-template}
CONSUL_CONFIG=${CONSUL_CONFIG:-/etc/consul-template/consul-template.cfg}
CONSUL_CONNECT=${CONSUL_CONNECT:-consul.service.consul:8500}
CONSUL_MINWAIT=${CONSUL_MINWAIT:-2s}
CONSUL_MAXWAIT=${CONSUL_MAXWAIT:-10s}
CONSUL_LOGLEVEL=${CONSUL_LOGLEVEL:-info}


if [[ -n ${CONSUL_TOKEN} ]]; then
	ctargs="${ctargs} -token ${CONSUL_TOKEN}"
fi

"${CONSUL_TEMPLATE}" -config "${CONSUL_CONFIG}" \
		 -log-level "${CONSUL_LOGLEVEL}" \
		 -wait "${CONSUL_MINWAIT}:${CONSUL_MAXWAIT}" \
		 -consul "${CONSUL_CONNECT}" ${ctargs} $*
