# vim: set sw=4 sts=4 et :

find "${IMAGE}" -name '*.la' ! -name libltdl.la ! -name libosp.la ! -name libcc1.la -exec rm '{}' +
