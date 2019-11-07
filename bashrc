CHOST="x86_64-pc-linux-gnu"

base_CFLAGS="-march=native -pipe -O2"
base_LDFLAGS="-Wl,-O1 -Wl,--as-needed"

# Manual action required, stupid configure.ac:
# - glibc

# ELF hack, Segments overlap
# - firefox

# Failed to find symbol
# - GPaste

# undefined symbol
# - libnftnl

# Uses ld with no objects + segv in g_thread when built with clang
# - glib

# Nested function declaration
# - v4l-utils

# Missing support for -Wl,--gc-sections
# - NetworkManager

# Unknown directive in asm
# - kexec-tools

# Exported symbols missing
# - spidermonkey

# error: statement not allowed in constexpr constructor
# - polkit

# Uses gcc extensions
# - libgcrypt
# - elfutils

# efivar.h not found?
# - efibootmgr

# sizeof(char) == 0
# - libatomic

case "${CATEGORY}/${PN}" in
    "dev-lang/llvm")
        base_CFLAGS+=" --stdlib=libc++"
        ;;
esac

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
    "dev-libs/spidermonkey"|"sys-auth/polkit")
        PATH="/usr/share/exherbo/banned_by_distribution:/etc/env.d/alternatives/cc/gcc/usr/${CHOST}/bin:/etc/env.d/alternatives/c++/gcc/usr/${CHOST}/bin:${PATH}"
        ;;
esac

case "${CATEGORY}/${PN}" in
    "dev-libs/libgcrypt"|"dev-util/elfutils"|"media-libs/v4l-utils"|"net-apps/NetworkManager"|"sys-apps/kexec-tools"|"sys-boot/efibootmgr"|"sys-libs/libatomic")
        PATH="/usr/share/exherbo/banned_by_distribution:/etc/env.d/alternatives/cc/gcc/usr/${CHOST}/bin:${PATH}"
        ;;
esac

case "${CATEGORY}/${PN}" in
    "media-libs/v4l-utils")
        base_LDFLAGS+=" -lpthread"
        ;;
esac

case "${CATEGORY}/${PN}" in
    "app-arch/cpio"|"sys-devel/m4")
        base_CFLAGS+=" --rtlib=compiler-rt"
        ;;
esac

case "${CATEGORY}/${PN}" in
    "dev-util/valgrind")
        base_CFLAGS+=" -fgnuc-version=6.1.0"
        ;;
esac

case "${CATEGORY}/${PN}" in
    "gnome-desktop/gnome-builder")
        base_CFLAGS+=" -Wno-shadow"
        ;;
esac

case "${CATEGORY}/${PN}" in
    "gnome-desktop/evince")
        base_CFLAGS+=" -Wno-format-nonliteral"
        ;;
esac

x86_64_pc_linux_gnu_CFLAGS="${base_CFLAGS}"
x86_64_pc_linux_gnu_CXXFLAGS="${base_CFLAGS}"
x86_64_pc_linux_gnu_LDFLAGS="${base_LDFLAGS}"

i686_pc_linux_gnu_CFLAGS="${base_CFLAGS}"
i686_pc_linux_gnu_CXXFLAGS="${base_CFLAGS}"
i686_pc_linux_gnu_LDFLAGS="${base_LDFLAGS}"

RUSTFLAGS="-C target-cpu=native -C opt-level=3"
