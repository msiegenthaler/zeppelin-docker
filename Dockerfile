FROM bedag/java:8u72

ENV VERSION=0.5.6

# Add Tini
ENV TINI_VERSION v0.9.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "-g", "--"]

RUN groupadd zeppelin && \
    useradd -d /opt/zeppelin -g zeppelin -s /bin/bash zeppelin

RUN . /etc/profile && \
    mkdir -p /opt && \
    echo "Downloading.." && \
    wget -q http://mirror.switch.ch/mirror/apache/dist/incubator/zeppelin/${VERSION}-incubating/zeppelin-${VERSION}-incubating-bin-all.tgz -O /opt/zeppelin.tgz && \
    echo "Extracting.." && \
    tar -xzf /opt/zeppelin.tgz -C /opt && \
    ln -s /opt/zeppelin-${VERSION}-incubating-bin-all /opt/zeppelin && \
    chown -R zeppelin:zeppelin /opt/zeppelin-${VERSION}-incubating-bin-all && \
    rm /opt/zeppelin.tgz

RUN mkdir -p /opt/zeppelin/logs && \
    chown zeppelin:zeppelin /opt/zeppelin/logs && \
    mkdir -p /opt/zeppelin/run && \
    chown zeppelin:zeppelin /opt/zeppelin/run

RUN mkdir -p /data && \
    chown zeppelin:zeppelin /data

ADD start-zeppelin.sh /

EXPOSE 8080

CMD [ "/start-zeppelin.sh" ]
