cp -R $JBOSS_LIBS/jboss-hibernate/*.jar $JBOSS_HOME/server/default/deploy/jboss-hibernate.deployer/
cp -R $JBOSS_LIBS/jboss-web/*.jar $JBOSS_HOME/server/default/deploy/jbossweb-tomcat50.sar/
cp -R $JBOSS_LIBS/postgres/*.jar $JBOSS_HOME/server/default/lib/
cp -R $JBOSS_LIBS/mondrian.war $JBOSS_HOME/server/default/deploy/mondrian.war
rm $JBOSS_HOME/server/default/deploy/jboss-hibernate.deployer/cglib-full-2.0.1.jar
rm $JBOSS_HOME/server/default/deploy/jboss-hibernate.deployer/hibernate2.jar

