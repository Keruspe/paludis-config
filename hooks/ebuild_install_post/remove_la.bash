# vim: set sw=4 sts=4 et :

find ${D} -name '*.la' ! -name libltdl.la ! -name libgnome-bluetooth.la ! -name libgnome-bluetooth-applet.la -exec rm '{}' +
