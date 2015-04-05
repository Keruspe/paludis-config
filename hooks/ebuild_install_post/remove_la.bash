# vim: set sw=4 sts=4 et :

find "${IMAGE}" -name '*.la' ! -name libltdl.la ! -name libosp.la -exec rm '{}' +
