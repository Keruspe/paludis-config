CHOST="x86_64-pc-linux-gnu"
MAKEOPTS="-j9"
CUSTOM_CFLAGS="-march=native -O3 -pipe"
CFLAGS+=" ${CUSTOM_CFLAGS}"
CXXFLAGS+=" ${CUSTOM_CFLAGS}"
LDFLAGS+=" -Wl,-O2"

case "${CATEGORY}/${PN}" in
    "sys-apps/paludis")
        CXXFLAGS+=" -g -ggdb3 -DHAVE_FFS"
        ;;
    "net-libs/neon")
        LDFLAGS+=" -lgcrypt"
        ;;
    "dev-libs/glib"|"dev-util/gdbus-codegen")
        EGIT_BRANCH="glib-2-30"
        ;;
    "media-libs/clutter")
        EGIT_BRANCH="clutter-1.8"
        ;;
    "media-libs/cogl")
        EGIT_BRANCH="cogl-1.8"
#    "gnome-base/gnome-shell"|"dev-libs/gobject-introspection"|"dev-libs/gjs"|"x11-wm/mutter")
#        CFLAGS+=" -g -ggdb3 -O0"
#        ;;
esac

