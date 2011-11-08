# vim: set sw=4 sts=4 et :

find ${D} -name '*.la' ! -name libltdl.la -exec rm '{}' +
