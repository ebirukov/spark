FROM ebirukov/docker-spark
MAINTAINER e.birukov
COPY configure.sh /etc/profile.d/
RUN apt-get update \
        && apt-get install -y python-pip unzip curl jq nano m4 python-pandas \
        && pip install awscli \
        && rm -rf /var/lib/apt/lists/* \
        && mkdir -p /root/.aws \
        && chmod +x /etc/profile.d/configure.sh

ADD docker-run-spark-env.sh /usr/local/bin/docker-run-spark-env.sh
ADD script-runner.sh /usr/local/bin/script-runner.sh
ADD mysql-connector-java-5.1.30-bin.jar usr/local/spark/lib/
ENTRYPOINT ["script-runner.sh"]
