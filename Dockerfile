FROM python:3.12.7-alpine3.20

RUN wget -O /opt/1.2.0.tar.gz https://github.com/aliyun/oss-ftp/archive/refs/tags/1.2.0.tar.gz && \
tar -zxvf /opt/1.2.0.tar.gz -C /opt/ && rm -rf /opt/1.2.0.tar.gz && chmod 755 /opt/oss-ftp-1.2.0/start.sh

WORKDIR /opt/oss-ftp-1.2.0

RUN export LC_ALL=en_US.UTF-8; export LANG="en_US.UTF-8"; locale

ENV TZ=Asia/Shanghai

CMD ./start.sh
