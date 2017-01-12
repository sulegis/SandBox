FROM ubuntu:14.04
MAINTAINER sulele@supermap.com

# 安装依赖
ADD sources.list /etc/apt/sources.list
RUN apt-get update 
RUN apt-get install -y libx11-dev xinit gcc wget libgomp1 libxtst6 libxi6 libc6-i386 libglu1-mesa libxcursor1 language-pack-zh-hans

ENV Config_PATH=/opt/iserver_config
ENV iServer_PATH=/etc/icloud/SuperMapiServer
ENV ISERVER_VERSION 8.1.0
ENV iServer true

RUN bash -c 'mkdir /etc/icloud && mkdir $Config_PATH'

# Install
ADD ./supermap_iserver_*.tar.gz /tmp
RUN mv /tmp/supermap_iserver* $iServer_PATH
RUN cp $iServer_PATH/support/objectsjava/bin/libmawt.so $iServer_PATH/support/jre/lib/amd64/headless && \
	mv $iServer_PATH/webapps/iserver/WEB-INF/iserver-*.* $Config_PATH && \
	mv $iServer_PATH/webapps/iserver/WEB-INF/config $Config_PATH && \
	mv $iServer_PATH/webapps/iserver/WEB-INF/backup $Config_PATH
RUN sed -i '1a JAVA_OPTS="$JAVA_OPTS -Diserver.config=$Config_PATH -Djava.security.egd=file:/dev/./urandom"' $iServer_PATH/bin/catalina.sh

ADD run.sh /opt/
ADD wait-for-it.sh /opt/
ADD wait-for-mysql.sh /opt/
RUN chmod 777 /etc/icloud/SuperMapiServer/bin/catalina.sh
RUN chmod 777 /opt/run.sh
RUN apt-get install -y mysql-client
RUN chmod 777 /opt/wait-for-mysql.sh

EXPOSE 8090

# Container启动时立即运行iServer
WORKDIR /opt
CMD /opt/run.sh
