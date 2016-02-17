#!/bin/sh
/etc/init.d/dbus start
/etc/init.d/avahi-daemon start
/opt/forked-daapd/sbin/forked-daapd -f
