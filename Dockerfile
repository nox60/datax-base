FROM openjdk:8u312-jdk-slim

RUN export LANG="zh_CN.UTF-8"

RUN rm -rf /usr/local/tomcat/webapps/

ADD code20root/target/code20root.war /usr/local/tomcat/webapps/
#ADD diancan0/target/diancan0.war /usr/local/tomcat/webapps/
#ADD shitang/target/shitang.war /usr/local/tomcat/webapps/


VOLUME ["/opt/local/uploadFiles/"]

ADD Shanghai /etc/localtime