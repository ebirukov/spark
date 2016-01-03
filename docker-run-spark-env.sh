#!/bin/bash
DOCKER_HOSTNAME=`curl -s http://169.254.169.254/latest/meta-data/public-hostname`
export SPARK_MASTER_PORT=7077
export  SPARK_MASTER_WEBUI_PORT=8080
export SPARK_WORKER_PORT=8888
export SPARK_WORKER_WEBUI_PORT=8081
export SPARK_MASTER_OPTS="$SPECIAL_SPARK_OPTS"
export SPARK_WORKER_OPTS="$SPECIAL_SPARK_OPTS"
export SPARK_JAVA_OPTS="$SPECIAL_SPARK_OPTS"

export SPARK_MASTER_IP=$DOCKER_HOSTNAME
export SPARK_LOCAL_IP=$DOCKER_HOSTNAME
export SPARK_LOCAL_HOSTNAME=$DOCKER_HOSTNAME

cat /usr/local/spark/conf/template-core-site.xml | m4 -DAWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -DAWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY > /usr/local/spark/conf/core-site.xml
cat /usr/local/spark/conf/template-hive-site.xml | m4 -DDB_CONNECTION_URL=$DB_CONNECTION_URL -DDB_PASS=$DB_PASS > /usr/local/spark/conf/hive-site.xml
env | grep SPARK | awk '{print "export \"" $0 "\""}' > /usr/local/spark/conf/spark-env.sh
export CLASSPATH="/usr/local/spark/lib/mysql-connector-java-5.1.30-bin.jar"
exec $@
