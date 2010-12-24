CHOST="x86_64-pc-linux-gnu"
MAKEOPTS="-j5"
CFLAGS="-march=native -O2 -pipe"
CXXFLAGS="${CFLAGS}"
LDFLAGS="${LDFLAGS} -Wl,-O2"

case "${CATEGORY}/${PN}" in
	"sys-apps/paludis")
		CXXFLAGS="${CXXFLAGS} -g -ggdb3 -DHAVE_FFS"
		;;
	"dev-python/docutils")
		LC_ALL="fr_FR.UTF-8"
		;;
	"net-libs/neon"|"gnome-base/gnome-vfs")
		LDFLAGS="${LDFLAGS} -lgcrypt"
		;;
	"gnome-base/gnome-shell"|"gnome-base/gnome-settings-daemon"|"dev-libs/gobject-introspection"|"dev-libs/gjs")
		CFLAGS+=" -g -ggdb3"
		;;
esac

