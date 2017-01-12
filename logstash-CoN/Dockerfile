FROM logstash:2.4.1

ADD ./consul-template /usr/local/bin

#Setup Consul Template Files
RUN mkdir /etc/consul-templates
#ADD ./config-template/logstash.conf.ctmpl /etc/consul-templates
#ENV CT_FILE /etc/consul-templates/logstash.conf
ENV CT_FILE /etc/consul-templates/logstash.conf.ctmpl

#Setup LogStash ConfigFile
ENV LG_FILE /etc/logstash/conf.d/logstash-iserver.conf

#Default Variables
ENV CONSUL consul:8500
ENV SERVICE consul-8500

CMD /docker-entrypoint.sh -r -f /etc/logstash/conf.d/ --auto-reload --reload-interval 2 \
& CONSUL_TEMPLATE_LOG=debug consul-template \
  -consul=$CONSUL \
  -template "$CT_FILE:$LG_FILE:echo 'reloaded'";
