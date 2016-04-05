#FROM hypriot/rpi-alpine-scratch:v3.2
FROM alpine:3.2

ARG VERSION=23.4

RUN   apk add --update \
        build-base openssl \
        autoconf automake \
        libevent libevent-dev \
        libplist libplist-dev \
        alsa-lib alsa-lib-dev \
        libgcrypt libgcrypt-dev \
        confuse confuse-dev \
        gettext gettext-dev \
        avahi avahi-dev  \ 
        ffmpeg ffmpeg-dev \
        sqlite-libs sqlite-dev \
        musl-dev libtool gperf openjdk7-jre-base \
        bsd-compat-headers && rm -rf /var/cache/apk/* \
      && wget https://github.com/ejurgensen/forked-daapd/archive/$VERSION.tar.gz -P /tmp \
      && wget http://www.antlr3.org/download/antlr-3.4-complete.jar -P /tmp \
      && wget http://www.antlr3.org/download/C/libantlr3c-3.4.tar.gz -P /tmp \
      && wget http://ftp.gnu.org/gnu/libunistring/libunistring-0.9.5.tar.xz -P /tmp \
      && wget http://www.msweet.org/files/project3/mxml-2.7.tar.gz -P /tmp \
      && tar -xzf /tmp/$VERSION.tar.gz -C /tmp \
      && tar -xzf /tmp/libantlr3c-3.4.tar.gz -C /tmp \
      && tar -xJf /tmp/libunistring-0.9.5.tar.xz -C /tmp \
      && tar -xzf /tmp/mxml-2.7.tar.gz -C /tmp \

      
      # Build libunistring
      && cd /tmp/libunistring-0.9.5 \
      && autoreconf -i \
      && ./configure --prefix=/usr \
      && make \
      && make install \
        

        
      # Build libantlr3c
      && cd /tmp/libantlr3c-3.4 \
      && ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --localstatedir=/var \
        --enable-64bit \
      && make \
      && make install \
      
      
      
      # Prepare antlr3
      && echo "#!/bin/sh" > /tmp/antlr3 \
      && echo "exec java -cp /tmp/antlr-3.4-complete.jar org.antlr.Tool \"\$@\"" >> /tmp/antlr3 \
      && chmod a+x /tmp/antlr3 \

      
      
      # Build mxml
      && cd /tmp/mxml-2.7 \
      && ./configure \
        --prefix=/usr \
        --localstatedir=/var \
      && make \
      && make install \

      
      # Build forked-daapd
      && cd /tmp/forked-daapd-$VERSION \
      && autoreconf -i -v \     
      && export PATH=$PATH:/tmp \
      && ./configure \
          --prefix=/usr \
          --sysconfdir=/etc \
          --localstatedir=/var \
          --enable-itunes \
      && make \
      && make install \
      
      
      # Clean UP
      && rm -R -f /tmp/* \
      && apk del \
        build-base \
         libevent-dev \
         libplist-dev \
         alsa-lib-dev \
         libgcrypt-dev \
         confuse-dev \
         gettext-dev \
         avahi-dev sqlite-dev \ 
         ffmpeg-dev \
        musl-dev libtool gperf openjdk7-jre-base \
        bsd-compat-headers
      
        

#ADD startServices.sh /root/startServices.sh
EXPOSE 3689

#CMD sh /root/startServices.sh
