#!/bin/bash

[ -z "$JBOSS_HOME" ] && JBOSS_HOME="/opt/jboss"

cp -vR ./jboss-hibernate/*.jar $JBOSS_HOME/server/default/deploy/jboss-hibernate.deployer/
cp -vR ./jboss-web/*.jar $JBOSS_HOME/server/default/deploy/jbossweb-tomcat50.sar/
cp -vR ./postgres/*.jar $JBOSS_HOME/server/default/lib/
cp -vR ./mondrian.war $JBOSS_HOME/server/default/deploy/

cp -v ./scripts/jboss_init_debian.sh $JBOSS_HOME/bin/

rm $JBOSS_HOME/server/default/deploy/jboss-hibernate.deployer/cglib-full-2.0.1.jar
rm $JBOSS_HOME/server/default/deploy/jboss-hibernate.deployer/hibernate2.jar
