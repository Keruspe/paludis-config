CFLAGS="-march=native -pipe -O3"
CXXFLAGS="${CFLAGS}"
LDFLAGS="-Wl,-O3 -Wl,--as-needed"

case "${CATEGORY}/${PN}" in
    "sys-apps/paludis")
        CXXFLAGS+=" -g -ggdb3"
        ;;
    "media-libs/libvorbis")
        LDFLAGS+=" -lm"
        ;;
esac
