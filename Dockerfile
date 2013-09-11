FROM ubuntu
MAINTAINER Raffaele Messuti <raffaele@atomotic.com>

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get -qq update
RUN apt-get -qq install tomcat6 curl

RUN curl -s -L sourceforge.net/projects/archive-access/files/wayback/1.6.0/wayback-1.6.0.tar.gz/download | tar -C /opt -zxvf  -

RUN service tomcat6 stop
RUN rm -fr /var/lib/tomcat6/webapps/ROOT
RUN cp /opt/wayback/wayback-1.6.0.war /var/lib/tomcat6/webapps/ROOT.war

RUN service tomcat6 start
RUN sleep 5
RUN service tomcat6 stop

ADD files/wayback.xml /var/lib/tomcat6/webapps/ROOT/WEB-INF/wayback.xml
ADD files/BDBCollection.xml /var/lib/tomcat6/webapps/ROOT/WEB-INF/BDBCollection.xml

EXPOSE 8080:8080
CMD service tomcat6 start && tail -f /var/log/tomcat6/catalina.out

