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
#    "gnome-base/gdm")
#        EGIT_BRANCH="wip/shell-greeter"
#        ;;
#    "gnome-base/gnome-shell")
#        EGIT_BRANCH="wip/gdm-shell"
#        ;;
#    "gnome-base/gnome-shell"|"dev-libs/gobject-introspection"|"dev-libs/gjs"|"x11-wm/mutter")
#        CFLAGS+=" -g -ggdb3 -O0"
#        ;;
esac

