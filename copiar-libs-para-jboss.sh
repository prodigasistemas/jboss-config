#!/bin/bash

[ -z "$JBOSS_HOME" ] && JBOSS_HOME="/opt/jboss"

cp -R ./jboss-hibernate/*.jar $JBOSS_HOME/server/default/deploy/jboss-hibernate.deployer/
cp -R ./jboss-web/*.jar $JBOSS_HOME/server/default/deploy/jbossweb-tomcat50.sar/
cp -R ./postgres/*.jar $JBOSS_HOME/server/default/lib/
cp -R ./mondrian.war $JBOSS_HOME/server/default/deploy/

cp ./scripts/jboss_init_debian.sh $JBOSS_HOME/bin/
cp ./scripts/deploy.sh $JBOSS_HOME/server/default/

rm $JBOSS_HOME/server/default/deploy/jboss-hibernate.deployer/cglib-full-2.0.1.jar
rm $JBOSS_HOME/server/default/deploy/jboss-hibernate.deployer/hibernate2.jar

cp ./docs/dtd/* "$JBOSS_HOME/docs/dtd"
