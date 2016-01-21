cp -R $GSAN_PATH/lib/jboss-config/jboss-hibernate/*.jar $JBOSS_HOME/server/default/deploy/jboss-hibernate.deployer/
cp -R $GSAN_PATH/lib/jboss-config/jboss-web/*.jar $JBOSS_HOME/server/default/deploy/jbossweb-tomcat50.sar/
cp -R $GSAN_PATH/lib/jboss-config/postgres/*.jar $JBOSS_HOME/server/default/lib/
cp -R $GSAN_PATH/lib/jboss-config/mondrian.war $JBOSS_HOME/server/default/deploy/mondrian.war
rm $JBOSS_HOME/server/default/deploy/jboss-hibernate.deployer/cglib-full-2.0.1.jar
rm $JBOSS_HOME/server/default/deploy/jboss-hibernate.deployer/hibernate2.jar

