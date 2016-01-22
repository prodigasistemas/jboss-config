#!/bin/bash

# chkconfig: 345 96 10
# description: jBoss EJB container
# processname: jbossrun
# pidfile: /var/run/jboss4.pid

JBOSS_HOME=/opt/jboss

# Source function library.
. /etc/rc.d/init.d/functions

case "$1" in
  start)
    echo "INICIANDO JBOSS ..."
    cd /opt/jboss/bin/
		
		if [ "$USER" = "root" ]; then
      su -l jenkins -c "nohup $JBOSS_HOME/bin/run.sh > /dev/null &"
		else
      nohup $JBOSS_HOME/bin/run.sh > /dev/null &
		fi
    ;;

  stop)
    echo "PARANDO JBOSS ..."
		JBOSSPID=`ps aux | grep "org.jboss.Main" | grep -v grep | awk '{print $2}'`
	
		if [ ! -z "$JBOSSPID" ]; then
			kill -9 $JBOSSPID
		else
			echo "Servidor Jboss nao esta iniciado"
		fi
    ;;

  restart)
    $0 stop
    $0 start
    ;;
  *)

  echo "usage: $0 (start|stop|restart)"
  exit 1
esac

exit 0
