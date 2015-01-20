CFLAGS="-march=native -pipe -O3"
CXXFLAGS="${CFLAGS}"
LDFLAGS="-Wl,-O3 -Wl,--as-needed"

case "${CATEGORY}/${PN}" in
    "dev-lang/go")
        CFLAGS+=" -O2"
        ;;
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
