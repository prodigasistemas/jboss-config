#!/bin/bash

ARQUIVO_ZIP=$1

if [ -z "$ARQUIVO_ZIP" ]; then
  echo "Precisa especificar qual arquivo ZIP sera implantado, exemplo: => sh deploy_gcom.sh gsan-1.0.0.ear.zip"
  exit 1
else
  if [ ! -e "$ARQUIVO_ZIP" ]; then
    echo "O arquivo $ARQUIVO_ZIP nao foi encontrado"
    exit 1
  else
    echo "> Descompactando o build $ARQUIVO_ZIP"
    unzip -q $ARQUIVO_ZIP

    mv $ARQUIVO_ZIP versions/

    echo "> Parando o servidor Jboss para iniciar um novo deploy"
    /etc/init.d/jboss stop

    echo "> Apagando as pastas temporarias e o build atual"
    rm -rf tmp/*
    rm -rf work/*
    rm -rf deploy/gcom*.ear
    rm -rf deploy/gsan*.ear

    echo "> Copiando o build especificado para deploy"
    mv gsan*.ear deploy/

    echo "> Inicializando o servidor Jboss para o novo deploy"
    /etc/init.d/jboss start

    exit 0
  fi
fi
