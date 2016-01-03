#!/bin/bash
cat /usr/local/spark/conf/template-core-site.xml | m4 -DAWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -DAWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY > /usr/local/spark/conf/core-site.xml
env | grep SPARK | awk '{print "export \"" $0 "\""}' > /usr/local/spark/conf/spark-env.sh

exec $@
