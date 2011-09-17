CHOST="x86_64-pc-linux-gnu"
CFLAGS="-march=native -pipe -O3"
CXXFLAGS="${CFLAGS}"

case "${CATEGORY}/${PN}" in
    "sys-apps/paludis")
        CXXFLAGS+=" -g -ggdb3 -DHAVE_FFS"
        ;;
esac
