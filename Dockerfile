FROM python:3.12.7-alpine3.20

RUN wget -O /opt/1.2.0.tar.gz https://github.com/aliyun/oss-ftp/archive/refs/tags/1.2.0.tar.gz && \
tar -zxvf /opt/1.2.0.tar.gz -C /opt/ && rm -rf /opt/1.2.0.tar.gz && chmod 755 /opt/oss-ftp-1.2.0/start.sh

WORKDIR /opt/oss-ftp-1.2.0

# 安装 glibc 和配置 locale
RUN apk --no-cache add ca-certificates && \
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    GLIBC_VERSION="2.35-r0" && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk && \
    apk add --no-cache glibc-${GLIBC_VERSION}.apk && \
    rm glibc-${GLIBC_VERSION}.apk && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk && \
    apk add --no-cache glibc-bin-${GLIBC_VERSION}.apk && \
    rm glibc-bin-${GLIBC_VERSION}.apk && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-i18n-${GLIBC_VERSION}.apk && \
    apk add --no-cache glibc-i18n-${GLIBC_VERSION}.apk && \
    rm glibc-i18n-${GLIBC_VERSION}.apk && \
    /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8 || true

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

ENV TZ=Asia/Shanghai

CMD ./start.sh
