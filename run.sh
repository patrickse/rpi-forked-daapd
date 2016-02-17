docker run -ti --rm --name forked-daapd -v /etc/forked-daapd.conf:/opt/forked-daapd/etc/forked-daapd.conf --net host -v /media/drive_b/music/:/media/drive_b/music  patrickse/rpi-forked-daapd bash
