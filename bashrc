CHOST="x86_64-pc-linux-gnu"

base_CFLAGS="-march=native -pipe -O2"
base_LDFLAGS="-Wl,-O1 -Wl,--as-needed"

# Manual action required:
# - bat
# - glibc

# Stupid configure.ac
# - glibc

# Calls ld without objects
# - glib

# ELF hack, Segments overlap
# - firefox

# duplicate symbol
# - bat
# - dconf
# - keyutils
# - lvm2

# Failed to find symbol
# - GPaste

case "${CATEGORY}/${PN}" in
    "gnome-desktop/dconf"|"gnome-desktop/GPaste"|"net-www/firefox"|"sys-apps/keyutils"|"sys-fs/lvm2")
        base_CFLAGS+=" -fuse-ld=gold"
        ;;
esac

case "${CATEGORY}/${PN}" in
    "dev-lang/ruby"|"dev-libs/libIDL"|"gnome-desktop/libsoup"|"media-gfx/graphviz"|"media-libs/gstreamer"|"net-analyzer/wireshark"|"net-firewall/iptables"|"net-print/cups-filters"|"sys-devel/gettext"|"sys-libs/gdbm"|"sys-process/procps"|"sys-libs/readline"|"x11-dri/freeglut"|"x11-libs/libxkbfile")
        PATH="/usr/share/exherbo/banned_by_distribution:/etc/env.d/alternatives/cc/clang/usr/${CHOST}/bin:/etc/env.d/alternatives/c++/clang/usr/${CHOST}/bin:/etc/env.d/alternatives/cpp/clang/usr/${CHOST}/bin:${PATH}"
        ;;
esac

case "${CATEGORY}/${PN}" in
    "dev-libs/glib")
        PATH="/usr/share/exherbo/banned_by_distribution:/etc/env.d/alternatives/ld/gold/usr/${CHOST}/bin:${PATH}"
        ;;
esac

case "${CATEGORY}/${PN}" in
    "app-text/poppler"|"dev-libs/protobuf"|"media-libs/v4l-utils"|"net-scanner/nmap"|"net-print/cups-filters"|"sys-devel/cmake")
        base_LDFLAGS+=" -lpthread"
        ;;
esac

case "${CATEGORY}/${PN}" in
    "dev-util/valgrind")
        base_LDFLAGS+=" -Wl,-z,notext"
        ;;
esac

x86_64_pc_linux_gnu_CFLAGS="${base_CFLAGS}"
x86_64_pc_linux_gnu_CXXFLAGS="${base_CFLAGS}"
x86_64_pc_linux_gnu_LDFLAGS="${base_LDFLAGS}"

i686_pc_linux_gnu_CFLAGS="${base_CFLAGS}"
i686_pc_linux_gnu_CXXFLAGS="${base_CFLAGS}"
i686_pc_linux_gnu_LDFLAGS="${base_LDFLAGS}"

RUSTFLAGS="-C target-cpu=native"

case "${CATEGORY}/${PN}" in
    net-www/firefox)
        RUSTFLAGS+=" -C opt-level=2"
        ;;
    *)
        RUSTFLAGS+=" -C opt-level=3"
        ;;
esac
