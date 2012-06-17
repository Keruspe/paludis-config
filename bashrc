CFLAGS="-march=native -pipe -O3"
CXXFLAGS="${CFLAGS}"
LDFLAGS="-Wl,-O3 -Wl,--as-needed"

case "${CATEGORY}/${PN}" in
    "gnome-desktop/sushi")
        LDFLAGS+=" -lfreetype"
	;;
    "media-libs/libcanberra")
        CFLAGS+=" -lX11"
        ;;
    "sys-apps/paludis")
        CXXFLAGS+=" -g -ggdb3"
        ;;
    "sys-libs/pam")
        CFLAGS+=" -DYPERR_SUCCESS=0"
        ;;
esac
