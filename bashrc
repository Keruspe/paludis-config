CFLAGS="-march=native -pipe -O3"
CXXFLAGS="${CFLAGS}"
LDFLAGS="-Wl,-O3 -Wl,--as-needed"

case "${CATEGORY}/${PN}" in
    "dev-util/elfutils")
        CFLAGS+=" -O2"
        ;;
    "gnome-desktop/sushi")
        LDFLAGS+=" -lfreetype"
        ;;
    "media-libs/libcanberra")
        LDFLAGS+=" -lX11"
        ;;
    "sys-apps/paludis")
        CXXFLAGS+=" -g -ggdb3"
        ;;
    "media/mplayer2"|"virtualization-lib/spice")
        LDFLAGS+=" -pthread"
        ;;
    "x11-libs/mx")
        LDFLAGS+=" -lm"
        ;;
    "gnome-desktop/GPaste")
        CFLAGS+=" -O1 -g -ggdb3"
        ;;
esac
