# 镜像制作以ubuntu 14.04操作系统为基础
FROM ubuntu:14.04

# 国内的Ubuntu镜像源
ADD sources.list /etc/apt/sources.list

# 安装依赖库
RUN sudo apt-get update;
RUN sudo apt-get -dy --reinstall install libc6-i386
RUN apt-get install -y lib32z1 lib32ncurses5 lib32bz2-1.0

 
