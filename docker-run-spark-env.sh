#!/bin/bash

env | grep SPARK | awk '{print "export \"" $0 "\""}' > /usr/local/spark/conf/spark-env.sh

exec $@
