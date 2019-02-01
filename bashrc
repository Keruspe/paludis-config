CHOST="x86_64-pc-linux-gnu"

base_CFLAGS="-march=native -pipe -O2"
base_LDFLAGS="-Wl,-O2 -Wl,--as-needed"

case "${CATEGORY}/${PN}" in
    "sys-apps/paludis")
        base_CFLAGS="-march=native -pipe -O0 -g -ggdb3"
        ;;
    "sys-apps/dbus-broker")
        base_CFLAGS="-march=native -pipe -O0 -g -ggdb3"
        ;;
    "net-www/firefox"|"dev-libs/spidermonkey"|"gnome-bindings/gjs")
        base_CFLAGS="-march=ivybridge -mtune=ivybridge -pipe -O2"
        base_LDFLAGS="-Wl,-O2"
        ;;
    "media-libs/v4l-utils"|"net-apps/NetworkManager")
        base_LDFLAGS="-Wl,-O2"
        ;;
esac

x86_64_pc_linux_gnu_CFLAGS="${base_CFLAGS}"
x86_64_pc_linux_gnu_CXXFLAGS="${base_CFLAGS}"
x86_64_pc_linux_gnu_LDFLAGS="${base_LDFLAGS}"

RUSTFLAGS="-C target-cpu=native"
