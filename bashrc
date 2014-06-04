CFLAGS="-march=native -pipe -O3"
CXXFLAGS="${CFLAGS}"
LDFLAGS="-Wl,-O3 -Wl,--as-needed"

case "${CATEGORY}/${PN}" in
    "sys-apps/paludis")
        CXXFLAGS="-march=native -pipe -O0 -g -ggdb3"
        CFLAGS="${CXXFLAGS}"
        ;;
    "sys-apps/systemd")
        CFLAGS+=" -fno-lto"
        LDFLAGS+=" -fno-lto"
        ;;
esac
