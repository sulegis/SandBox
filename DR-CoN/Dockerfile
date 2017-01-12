FROM nginx:1.7

#Install Curl
#RUN apt-get update -qq && apt-get -y install unzip curl

#Link to Consul Template Binary

#Install Consul Template
#ENV CT_URL https://releases.hashicorp.com/consul-template/0.16.0/consul-template_0.16.0_linux_amd64.zip
#RUN curl $CT_URL -o /tmp/ct.zip && unzip /tmp/ct.zip -d /usr/local/bin
#ADD consul-template_*.zip /tmp
ADD ./consul-template /usr/local/bin

#Setup Consul Template Files
RUN mkdir /etc/consul-templates
ENV CT_FILE /etc/consul-templates/nginx.conf

#Setup Nginx File
ENV NX_FILE /etc/nginx/conf.d/app.conf

#Default Variables
ENV CONSUL consul:8500
ENV SERVICE iserver-8090

# Command will
# 1. Write Consul Template File
# 2. Start Nginx
# 3. Start Consul Template

CMD echo "upstream app {                 \n\
  least_conn;                            \n\
  {{range service \"iserver-8090\"}}         \n\
  server  {{.Address}}:8090;        \n\
  {{else}}server 127.0.0.1:65535;{{end}} \n\
}                                        \n\
server {                                 \n\
  listen 80 default_server;              \n\
  location / {                           \n\
    rewrite     ^(.*)   http://\$host:\$server_port/iserver\$1 permanent;     \n\
  }                                      \n\
  location /iserver {                           \n\
    proxy_pass http://app;               \n\
    proxy_set_header Host \$http_host;             \n\
    proxy_set_body \$request_body;               \n\
  }                                      \n\
}" > $CT_FILE; \
/usr/sbin/nginx -c /etc/nginx/nginx.conf \
& CONSUL_TEMPLATE_LOG=debug consul-template \
  -consul=$CONSUL \
  -template "$CT_FILE:$NX_FILE:/usr/sbin/nginx -s reload";
