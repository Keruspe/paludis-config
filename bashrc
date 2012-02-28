CFLAGS="-march=native -pipe -O3"
CXXFLAGS="${CFLAGS}"
LDFLAGS="-Wl,--as-needed -Wl,-O3"

case "${CATEGORY}/${PN}" in
    "sys-apps/paludis")
        CXXFLAGS+=" -g -ggdb3"
        ;;
    "sys-libs/pam")
        CFLAGS+=" -DYPERR_SUCCESS=0"
        ;;
esac
