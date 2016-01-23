FROM ubuntu:wily

MAINTAINER Zankard <zankard@gmail.com>

ENV SERVICE="server"
ENV PORT=8388
ENV FORWARD
ENV PASSWORD
ENV VERBOSE

RUN deps="build-essential git-core ca-certificates autoconf libtool libssl-dev" \
  && apt-get update \
  && apt-get -y update && apt-get install -y $deps --no-install-recommends \
  && git clone https://github.com/shadowsocks/shadowsocks-libev.git \
  && cd shadowsocks-libev \
  && ./configure \
  && make \
  && make install \
  && apt-get purge -y --auto-remove $deps \
  && cd / \
  && rm -rf /shadowsocks

EXPOSE $PORT

ADD entrypoint /
ENTRYPOINT ["/entrypoint"]
