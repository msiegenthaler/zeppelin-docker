FROM bedag/java:8u72

ENV VERSION=0.5.6

RUN . /etc/profile && \
    mkdir -p /opt && \
    wget -q http://mirror.switch.ch/mirror/apache/dist/incubator/zeppelin/${VERSION}-incubating/zeppelin-${VERSION}-incubating-bin-all.tgz -O /opt/zeppelin.tgz && \
    tar -xzf /opt/zeppelin.tgz -C /opt && \
    ln -s /opt/zeppelin-${VERSION}-incubating-bin-all && \
    rm /opt/zeppelin.tgz

EXPOSE 8080
