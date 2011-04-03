CHOST="x86_64-pc-linux-gnu"
MAKEOPTS="-j9"
CUSTOM_CFLAGS="-march=native -Ofast -pipe"
CFLAGS+=" ${CUSTOM_CFLAGS}"
CXXFLAGS+=" ${CUSTOM_CFLAGS}"
LDFLAGS+=" -Wl,-O2"

case "${CATEGORY}/${PN}" in
    "sys-apps/paludis")
		LET_ME_RICE=yes
        CXXFLAGS+=" -O3 -g -ggdb3 -DHAVE_FFS"
        ;;
    "net-libs/neon")
		LDFLAGS+=" -lgcrypt"
		;;
	"dev-db/sqlite")
		CFLAGS+=" -fno-fast-math"
		;;
#    "gnome-base/gnome-shell"|"dev-libs/gobject-introspection"|"dev-libs/gjs"|"x11-wm/mutter")
#        CFLAGS+=" -g -ggdb3 -O0"
#        ;;
    "net-libs/xulrunner"|"www-client/firefox")
        WANT_MP="true"
	CXXFLAGS+=" -mno-avx"
#        CXXFLAGS+=" -g -ggdb3 -O0"
        ;;
esac

