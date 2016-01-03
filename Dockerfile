FROM epahomov/docker-spark
MAINTAINER e.birukov
RUN apt-get update \
        && apt-get install -y python-pip unzip curl jq nano m4
ADD docker-run-spark-env.sh /usr/local/bin/docker-run-spark-env.sh
ADD template-hive-site.xml /usr/local/spark/conf/template-hive-site.xml
ADD template-core-site.xml /usr/local/spark/conf/template-core-site.xml
ADD mysql-connector-java-5.1.30-bin.jar usr/local/spark/lib/
