FROM openjdk:8u312-jdk-slim

RUN export LANG="zh_CN.UTF-8"

RUN rm -rf /usr/local/tomcat/webapps/

ADD target/target /opt/local/

VOLUME ["/opt/local/uploadFiles/"]

ADD Shanghai /etc/localtime
