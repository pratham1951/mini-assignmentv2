#!/bin/bash

sudo chmod 777 /var/lib/jenkins/workspace/test1/target/*.war
cp /var/lib/jenkins/workspace/test1/target/*.war /home/ubuntu/apache-tomcat-9.0.81/webapps


sh /home/ubuntu/apache-tomcat-9.0.81/bin/shutdown.sh
cp /var/lib/jenkins/workspace/test1/scripts/dev/server.xml /home/ubuntu/apache-tomcat-9.0.81/conf/
sh /home/ubuntu/apache-tomcat-9.0.81/bin/startup.sh
