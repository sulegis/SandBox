# 镜像制作以ubuntu 14.04操作系统为基础
FROM ubuntu:14.04

# 国内的Ubuntu镜像源
ADD sources.list /etc/apt/sources.list

# 安装依赖库
RUN apt-get update 
RUN apt-get install -y libx11-dev xinit gcc wget libgomp1 libxtst6 libxi6 libc6-i386 libglu1-mesa libxcursor1 language-pack-zh-hans

 
