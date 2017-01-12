# SandBox
Just Sandbox

##使用说明
 * 运行：sudo ./buildiServer.sh -e EXTERNAL_IP
 * 访问:  http://${EXTERNAL_IP} or http://${EXTERNAL_IP}/iserver 

##给iServer加节点
 * 启动后，再运行 sudo docker-compose scale iserver=2
 * 表示扩张为2个iserver节点，访问地址不变，http://${EXTERNAL_IP}

##后台管理地址
 * 查看iServer所有节点: http://${EXTERNAL_IP}:8500/v1/catalog/service/iserver"
 * "View Log Center At: http://${EXTERNAL_IP}:5601"
 * "View Mongodb At: http://${EXTERNAL_IP}:8081 , admin/supermap"
 * "View MySQL At: http://${EXTERNAL_IP}:8082 , iserver/iserver"
 * "View Consul At: http://${EXTERNAL_IP}:8500"

##TODO
 * 日志收集的集成
 * 节点监控的集成

##FAQ
 * elasticsearch启动失败：运行：sudo sysctl -w vm.max_map_count=262144
