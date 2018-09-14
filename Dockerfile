FROM openjdk:jre-alpine

ENV SBT_VERSION   1.2.1
ENV SBT_HOME      /usr/local/sbt
ENV PATH          ${PATH}:${SBT_HOME}/bin
ENV GLIBC_VERSION 2.28-r0

RUN apk --no-cache --update add bash wget && \
    mkdir -p "$SBT_HOME" && \
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC_VERSION/glibc-$GLIBC_VERSION.apk && \
    apk add glibc-$GLIBC_VERSION.apk && \
    rm glibc-$GLIBC_VERSION.apk && \
    wget -qO - --no-check-certificate "https://github.com/sbt/sbt/releases/download/v$SBT_VERSION/sbt-$SBT_VERSION.tgz" | tar xz -C $SBT_HOME --strip-components=1 && \
    apk del wget && \
    sbt sbtVersion

WORKDIR /app
