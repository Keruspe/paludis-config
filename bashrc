CHOST="x86_64-pc-linux-gnu"

base_CFLAGS="-march=native -pipe -O2"
base_LDFLAGS="-Wl,-O2 -Wl,--as-needed"

# Required until everything uses clang/lld and supports lto
LTO_FLAGS="-flto=thin"
GNUC_VERSION="6.4.0"
CUSTOM_CXXFLAGS=""

# glib:           SEGV in g_thread when using e.g. appstream-glib
# firefox:        error: no member named 'abort' in namespace 'std::__1'; did you mean simply 'abort'?
# GPaste:         need to debug that
# elfutils:       error: gcc with GNU99 support required
# kexec-tools:    error: unknown directive
# libatomic:      error: no 8-bit type, please report a bug
case "${CATEGORY}/${PN}" in
    "dev-libs/glib")
        PATH="/usr/share/exherbo/banned_by_distribution:/etc/env.d/alternatives/cc/gcc/usr/${CHOST}/bin:/etc/env.d/alternatives/ld/gold/usr/${CHOST}/bin:${PATH}"
        GNUC_VERSION=""
        LTO_FLAGS=""
        ;;
    "sys-auth/polkit")
        CUSTOM_CXXFLAGS="-std=c++17"
        ;;
    "net-www/firefox")
        CUSTOM_CXXFLAGS="--stdlib=libstdc++"
        ;;
    "gnome-desktop/GPaste")
        base_CFLAGS+=" -fuse-ld=gold --rtlib=libgcc"
        ;;
    "dev-util/elfutils"|"sys-apps/kexec-tools"|"sys-libs/libatomic")
        PATH="/usr/share/exherbo/banned_by_distribution:/etc/env.d/alternatives/cc/gcc/usr/${CHOST}/bin:${PATH}"
        GNUC_VERSION=""
        LTO_FLAGS=""
        ;;
    "sys-apps/systemd")
        EFI_LD=${CHOST}-ld.gold
        ;;
    "gnome-desktop/gnome-builder")
        base_CFLAGS+=" -Wno-shadow"
        ;;
    "gnome-desktop/evince")
        base_CFLAGS+=" -Wno-format-nonliteral"
        ;;
    "dev-lang/python"|"dev-libs/icu"|"sys-apps/fwupd"|"sys-fs/btrfs-progs"|"sys-libs/glibc"|"sys-libs/libgcc"|"x11-dri/mesa")
        GNUC_VERSION=""
        LTO_FLAGS=""
        ;;
esac

# gettext:  error: undefined symbol: sqrt
# elfutils: links to libstdc++ otherwise
case "${CATEGORY}/${PN}" in
    "sys-devel/gettext")
        base_LDFLAGS+=" -lm"
        ;;
    "dev-util/elfutils")
        CUSTOM_CXXFLAGS="-nostdinc++ -I/usr/include/c++/v1"
        base_LDFLAGS+=" -nodefaultlibs -lc++ -lc++abi -lm -lc"
        ;;
esac

base_CFLAGS+=" ${LTO_FLAGS}"
base_LDFLAGS+=" ${LTO_FLAGS}"

if [[ -n "${GNUC_VERSION}" ]]; then
    base_CFLAGS+=" -fgnuc-version=${GNUC_VERSION}"
fi

x86_64_pc_linux_gnu_CFLAGS="${base_CFLAGS}"
x86_64_pc_linux_gnu_CXXFLAGS="${base_CFLAGS} ${CUSTOM_CXXFLAGS}"
x86_64_pc_linux_gnu_LDFLAGS="${base_LDFLAGS}"

i686_pc_linux_gnu_CFLAGS="${base_CFLAGS}"
i686_pc_linux_gnu_CXXFLAGS="${base_CFLAGS} ${CUSTOM_CXXFLAGS}"
i686_pc_linux_gnu_LDFLAGS="${base_LDFLAGS}"

RUSTFLAGS="-C target-cpu=native -C opt-level=3"
