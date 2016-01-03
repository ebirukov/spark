#!/bin/bash
DOCKER_HOSTNAME=`curl -s http://169.254.169.254/latest/meta-data/public-hostname`
export SPARK_MASTER_PORT=7077
export  SPARK_MASTER_WEBUI_PORT=8080
export SPARK_WORKER_PORT=8888
export SPARK_WORKER_WEBUI_PORT=8081
export SPECIAL_SPARK_OPTS="-Dspark.driver.port=7001 -Dspark.fileserver.port=7002 -Dspark.broadcast.port=7003 -Dspark.replClassServer.port=7004 -Dspark.blockManager.port=7005 -Dspark.executor.port=7006 -Dspark.ui.port=4040 -Dspark.broadcast.factory=org.apache.spark.broadcast.HttpBroadcastFactory $SPECIAL_SPARK_OPTS"

export SPARK_MASTER_OPTS="$SPECIAL_SPARK_OPTS"
export SPARK_WORKER_OPTS="$SPECIAL_SPARK_OPTS"
export SPARK_JAVA_OPTS="$SPECIAL_SPARK_OPTS"

export SPARK_MASTER_IP=$DOCKER_HOSTNAME
export SPARK_LOCAL_IP=$DOCKER_HOSTNAME
export SPARK_LOCAL_HOSTNAME=$DOCKER_HOSTNAME

cat /usr/local/spark/conf/template-core-site.xml | m4 -DAWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -DAWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY > /usr/local/spark/conf/core-site.xml
#cat /usr/local/spark/conf/template-hive-site.xml | m4 -DDB_CONNECTION_URL=$DB_CONNECTION_URL -DDB_PASS=$DB_PASS > /usr/local/spark/conf/hive-site.xml
aws s3 cp s3://webgames-emr/hive/config/hive-site.xml /usr/local/spark/conf/hive-site.xml > /dev/null
env | grep SPARK | awk '{print "export \"" $0 "\""}' > /usr/local/spark/conf/spark-env.sh
export CLASSPATH="/usr/local/spark/lib/mysql-connector-java-5.1.30-bin.jar"
export PATH="$PATH:/usr/local/spark/bin"
exec $@
