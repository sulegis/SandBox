#!/bin/bash
URL_iServer=ftp://ftp.ispeco.com/iserver/releases_beta_formal/8.1.0_Formal_Release_20160927/supermap_iserver_8.1.0_linux64_deploy.tar.gz
URL_consul=ftp://ftp.ispeco.com/tools/consul-template_0.16.0_linux_amd64.zip

check_version() {
    VER=$(docker-compose version | head -n1 | sed s/,//g | awk '{ print $3 }')
    if [ "$VER" = $(echo -e "$VER\n1.6" | sort -V | head -n1) ]; then
        echo "You have to use docker-compose 1.6 or later."
        exit 1
    fi
}

check_mandatory_flags() {
  if [ -z "$EXTERNAL_IP" ]; then
    echo "external ip not set, use the -e flag." >&2
    usage
    exit 1
  fi
}
create_configuration_files() {
  substitutions="s|EXTERNAL_IP|${EXTERNAL_IP}|g"

  # compose setup
  sed -e "${substitutions}" compose/docker-compose.yml.template > docker-compose.yml
}
usage() {
  echo "Usage: $0 -e EXTERNAL_IP"
  echo "  -e EXTERNAL_IP - the IP or FQDN used to publish iServer and Consul"
}

while getopts "foe:hc:" opt; do
  case "${opt}" in
    e)
      EXTERNAL_IP=$OPTARG
      ;;
    h)
      usage
      exit 0
      ;;
    *)
      echo "Invalid option: -$OPTARG" >&2
      usage
      exit 1
      ;;
  esac
done
check_mandatory_flags
check_version
create_configuration_files
echo EXTERNAL_IP=$EXTERNAL_IP
export EXTERNAL_IP=$EXTERNAL_IP

mkdir -p ./iserver_data ./iserver_logs ./mysql_data
wget -nc $URL_iServer -O ./Dockerfile_iServer/supermap_iserver_8.1.0.tar.gz

wget -nc $URL_consul -O /tmp/consul-template.zip
unzip /tmp/consul-template.zip -d ./DR-CoN

echo `pwd`
docker-compose up -d 

cat <<EOM
###################
#     SUCCESS     #
###################
EOM

echo "Make sure port 8090 and 8081 are open on host"
printf "\n"

echo "View iServer At: http://${EXTERNAL_IP} or http://${EXTERNAL_IP}/iserver"
echo "View Log Center At: http://${EXTERNAL_IP}:5601"
echo "View Mongodb At: http://${EXTERNAL_IP}:8081 , admin/supermap"
echo "View MySQL At: http://${EXTERNAL_IP}:8082 , iserver/iserver"
echo "View Consul At: http://${EXTERNAL_IP}:8500"

printf "\n"
echo "Scale iServer Like: 'sudo docker-compose scale iserver=3' "
echo "View All iServer Nodes At: http://${EXTERNAL_IP}:8500/v1/catalog/service/iserver"
printf "\n"

