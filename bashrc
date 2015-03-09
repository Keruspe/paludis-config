CFLAGS="-march=native -pipe -O2"
CXXFLAGS="${CFLAGS}"
LDFLAGS="-Wl,-O2 -Wl,--as-needed"

case "${CATEGORY}/${PN}" in
    "sys-apps/paludis")
        CXXFLAGS="-march=native -pipe -O0 -g -ggdb3"
        CFLAGS="${CXXFLAGS}"
        ;;
    "dev-lang/node"|"net-www/nightly")
        CXXFLAGS="-march=native -pipe -O1"
        CFLAGS="${CXXFLAGS}"
        ;;
    "x11-libs/cairo")
        CFLAGS+=" -ffat-lto-objects"
        ;;
esac
