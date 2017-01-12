# 初始化许可驱动
cd /etc/icloud/SuperMapiServer/support/SuperMap_License/Support
tar xvf aksusbd*.tar
cd aksusbd*
./dunst
./dinst
echo
 
# 运行iServer
cd /etc/icloud/SuperMapiServer/bin
./catalina.sh run
