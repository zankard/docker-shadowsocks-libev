FROM debian:jessie

MAINTAINER Zankard <zankard@gmail.com>

ENV SERVICE="server"
ENV SERVER_ADDR ""
ENV SERVER_PORT=8388
ENV LOCAL_PORT=1080
ENV FORWARD_ADDR ""
ENV FORWARD_PORT ""
ENV PASSWORD ""
ENV VERBOSE ""

RUN deps="build-essential git-core ca-certificates autoconf libtool libssl-dev" \
  && apt-get update \
  && apt-get -y update && apt-get install -y libssl1.0.0 $deps --no-install-recommends \
  && git clone https://github.com/shadowsocks/shadowsocks-libev.git \
  && cd shadowsocks-libev \
  && ./configure \
  && make \
  && make install \
  && apt-get purge --auto-remove -y $deps \
  && cd / \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /shadowsocks-libev

ADD entrypoint /
ENTRYPOINT ["/entrypoint"]
