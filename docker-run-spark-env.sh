#!/bin/bash
public_hostname=`curl -s http://169.254.169.254/latest/meta-data/public-hostname`
echo $public_hostname
cat /usr/local/spark/conf/template-core-site.xml | m4 -DAWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -DAWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY > /usr/local/spark/conf/core-site.xml
cat /usr/local/spark/conf/template-hive-site.xml | m4 -DDB_CONNECTION_URL=$DB_CONNECTION_URL -DDB_PASS=$DB_PASS > /usr/local/spark/conf/hive-site.xml
env | grep SPARK | awk '{print "export \"" $0 "\""}' > /usr/local/spark/conf/spark-env.sh
export CLASSPATH="$CLASSPATH:/usr/local/spark/lib/mysql-connector-java-5.1.30-bin.jar"
exec $@
