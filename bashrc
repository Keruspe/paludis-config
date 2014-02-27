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
    "app-arch/snappy")
        CXXFLAGS+=" -pthread"
        ;;
    "net-www/firefox")
        CXXFLAGS+=" $(pkg-config --cflags pixman-1)"
        ;;
    "sys-apps/systemd")
        CFLAGS="-march=native -pipe -Og -ggdb3"
        LDFLAFS="-Wl,--as-needed"
        ;;
esac
