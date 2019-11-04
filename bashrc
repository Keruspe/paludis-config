CHOST="x86_64-pc-linux-gnu"

base_CFLAGS="-march=native -pipe -O2"
base_LDFLAGS="-Wl,-O1 -Wl,--as-needed"

# Manual action required, stupid configure.ac:
# - glibc

# ELF hack, Segments overlap
# - firefox

# Failed to find symbol
# - GPaste

# Uses ld with no objects + segv in g_thread when built with clang
# - glib

# Nested function declaration
# - v4l-utils

# Missing support for -Wl,--gc-sections
# - NetworkManager

case "${CATEGORY}/${PN}" in
    "gnome-desktop/GPaste"|"net-www/firefox")
        base_CFLAGS+=" -fuse-ld=gold"
        ;;
esac

case "${CATEGORY}/${PN}" in
    "dev-libs/glib")
        PATH="/usr/share/exherbo/banned_by_distribution:/etc/env.d/alternatives/cc/gcc/usr/${CHOST}/bin:/etc/env.d/alternatives/ld/gold/usr/${CHOST}/bin:${PATH}"
        ;;
esac

case "${CATEGORY}/${PN}" in
    "net-www/firefox")
        PATH="/usr/share/exherbo/banned_by_distribution:/etc/env.d/alternatives/cc/gcc/usr/${CHOST}/bin:/etc/env.d/alternatives/c++/gcc/usr/${CHOST}/bin:/etc/env.d/alternatives/ld/gold/usr/${CHOST}/bin:${PATH}"
        ;;
esac

case "${CATEGORY}/${PN}" in
    "media-libs/v4l-utils"|"net-apps/NetworkManager")
        PATH="/usr/share/exherbo/banned_by_distribution:/etc/env.d/alternatives/cc/gcc/usr/${CHOST}/bin:${PATH}"
        ;;
esac

x86_64_pc_linux_gnu_CFLAGS="${base_CFLAGS}"
x86_64_pc_linux_gnu_CXXFLAGS="${base_CFLAGS}"
x86_64_pc_linux_gnu_LDFLAGS="${base_LDFLAGS}"

i686_pc_linux_gnu_CFLAGS="${base_CFLAGS}"
i686_pc_linux_gnu_CXXFLAGS="${base_CFLAGS}"
i686_pc_linux_gnu_LDFLAGS="${base_LDFLAGS}"

RUSTFLAGS="-C target-cpu=native -C opt-level=3"
