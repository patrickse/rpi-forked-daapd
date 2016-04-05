#FROM debian:jessie
#FROM resin/rpi-raspbian:jessie
#FROM hypriot/rpi-alpine-scratch:v3.2
FROM alpine:3.2

ARG VERSION=23.4

RUN   apk add --update build-base openssl # && rm -rf /var/cache/apk/*
RUN   wget https://github.com/ejurgensen/forked-daapd/archive/$VERSION.tar.gz -P /tmp \
      && tar -xzf /tmp/$VERSION.tar.gz -C /tmp

RUN   apk add \ 
        autoconf automake \
        libgcrypt libgcrypt-dev \
        musl-dev libtool gperf \
      
RUN   cd /tmp/forked-daapd-$VERSION \
      && autoreconf -i \

#RUN apt-get update -y \
#    && apt-get install -y \
#     build-essential git autotools-dev autoconf libtool gettext gawk gperf \
#     antlr3 libantlr3c-dev libconfuse-dev libunistring-dev libsqlite3-dev \
#     libavcodec-dev libavformat-dev libavfilter-dev libswscale-dev libavutil-dev \
 #    libasound2-dev libmxml-dev libgcrypt11-dev libavahi-client-dev zlib1g-dev \
 #    libevent-dev
#
##RUN apt-get install -y avahi-daemon libavahi-client3#
#
#RUN apt-get install  -y \
##	libasound2-dev:armhf \
#	automake \
#	libtool \
	#libltdl-dev:armhf
#
##
#RUN git clone https://github.com/ejurgensen/forked-daapd.git /tmp/forked-daapd
#RUN cd /tmp/forked-daapd \
 #&& autoreconf -i \
 #&& ./configure --prefix=/opt/forked-daapd --localstatedir=/var \
 #&& make \
 ##&& make install \
 #&& rm -R -f /tmp/forked-daapd###
#
#ADD startServices.sh /root/startServices.sh
#
#EXPOSE 3689
#
##CMD sh /root/startServices.sh
