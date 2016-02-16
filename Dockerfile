#FROM debian:jessie
FROM resin/rpi-raspbian:jessie

RUN apt-get update -y \
    && apt-get install -y \
     build-essential git autotools-dev autoconf libtool gettext gawk gperf \
     antlr3 libantlr3c-dev libconfuse-dev libunistring-dev libsqlite3-dev \
     libavcodec-dev libavformat-dev libavfilter-dev libswscale-dev libavutil-dev \
     libasound2-dev libmxml-dev libgcrypt11-dev libavahi-client-dev zlib1g-dev \
     libevent-dev

RUN apt-get install  -y \
	libasound2-dev:armhf \
	automake \
	libtool \
	libltdl-dev:armhf


RUN git clone https://github.com/ejurgensen/forked-daapd.git /tmp/forked-daapd
RUN cd /tmp/forked-daapd \
 && autoreconf -i \
 && ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var \
 && make \
 && make install \
 && rm -R -f /tmp/forked-daapd

EXPOSE 3689

