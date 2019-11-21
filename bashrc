CHOST="x86_64-pc-linux-gnu"

base_CFLAGS="-march=native -pipe -O2"
base_LDFLAGS="-Wl,-O2,--as-needed"

# Required until everything uses clang/lld and supports lto
LTO_FLAGS="-flto=thin"
# gcc 7 introduced _Float stuff
GNUC_VERSION="6.5.0"
# Temporary workaround
CUSTOM_CXXFLAGS=""

case "${CATEGORY}/${PN}" in
    "dev-libs/glib")
        # SEGV in g_thread when using e.g. appstream-glib
        PATH="/usr/share/exherbo/banned_by_distribution:/etc/env.d/alternatives/cc/gcc/usr/${CHOST}/bin:/etc/env.d/alternatives/ld/gold/usr/${CHOST}/bin:${PATH}"
        GNUC_VERSION=""
        LTO_FLAGS=""
        ;;
    "dev-util/elfutils"|"sys-apps/kexec-tools"|"sys-libs/libatomic")
        # elfutils:    error: gcc with GNU99 support required
        # kexec-tools: error: unknown directive
        # libatomic:   error: no 8-bit type, please report a bug
        PATH="/usr/share/exherbo/banned_by_distribution:/etc/env.d/alternatives/cc/gcc/usr/${CHOST}/bin:${PATH}"
        GNUC_VERSION=""
        LTO_FLAGS=""
        ;;
    "gnome-desktop/GPaste")
        # need to debug that
        base_CFLAGS+=" -fuse-ld=gold --rtlib=libgcc"
        GNUC_VERSION="4.2.4"
        ;;
    "net-www/firefox")
        # error: no member named 'abort' in namespace 'std::__1'; did you mean simply 'abort'?
        CUSTOM_CXXFLAGS="--stdlib=libstdc++"
        GNUC_VERSION="4.2.4"
        ;;
    "app-arch/gzip"|"app-arch/tar"|"app-editors/vim"|"app-editors/vim-runtime"|"app-spell/enchant"|"base/libatasmart"|"dev-lang/ruby"|"dev-libs/gtk-vnc"|"dev-libs/libsodium"|"dev-libs/popt"|"dev-libs/spidermonkey"|"media-libs/libcanberra"|"media-libs/opus"|"media-sound/pulseaudio"|"net-misc/openssh"|"net-scanner/nmap"|"sys-apps/accountsservice"|"sys-apps/coreutils"|"sys-apps/kbd"|"sys-apps/sed"|"sys-boot/dracut"|"sys-devel/gdb"|"sys-devel/m4"|"x11-libs/cairo")
        # error: undefined symbol: __builtin_va_arg_pack  (introduced in gcc 4.3)
        GNUC_VERSION="4.2.4"
        ;;
    "sys-apps/systemd")
        # otherwise sd-boot displays and does nothing
        EFI_LD="${CHOST}-ld.gold"
        # error: static_assert expression is not an integral constant expression
        GNUC_VERSION="4.5.4"
        ;;
    "sys-auth/polkit")
        CUSTOM_CXXFLAGS="-std=c++17"
        ;;
    "gnome-desktop/gnome-builder")
        base_CFLAGS+=" -Wno-shadow"
        ;;
    "gnome-desktop/evince")
        base_CFLAGS+=" -Wno-format-nonliteral"
        ;;
    "dev-lang/erlang")
        # Figure out a proper version that makes configure pass
        GNUC_VERSION=""
        ;;
    "dev-lang/perl"|"dev-lang/python")
        LTO_FLAGS=""
        ;;
    "dev-libs/libgcrypt"|"dev-libs/libglvnd"|"dev-util/strace"|"dev-util/valgrind"|"media-libs/x264"|"net-print/cups"|"sys-apps/fwupd"|"sys-boot/gnu-efi"|"sys-devel/gcc"|"sys-devel/libostree"|"sys-fs/btrfs-progs"|"sys-libs/glibc"|"sys-libs/libgcc"|"sys-libs/libstdc++"|"x11-dri/mesa"|"x11-libs/pango")
        #GNUC_VERSION=""
        #LTO_FLAGS=""
        ;;
esac

# elfutils: links to libstdc++ otherwise
# gettext:  error: undefined symbol: sqrt
# cairo:    error: undefined reference to pthread_mutexattr_init
case "${CATEGORY}/${PN}" in
    "dev-util/elfutils")
        CUSTOM_CXXFLAGS="-nostdinc++ -I/usr/include/c++/v1"
        base_LDFLAGS+=" -nodefaultlibs -lc++ -lc++abi -lm -lc"
        ;;
    "sys-devel/gettext")
        base_LDFLAGS+=" -lm"
        ;;
    "x11-libs/cairo")
        base_LDFLAGS+=" -lpthread"
        ;;
esac

if [[ -n "${LTO_FLAGS}" ]]; then
    base_CFLAGS+=" ${LTO_FLAGS}"
    base_LDFLAGS+=" ${LTO_FLAGS}"
fi

if [[ -n "${GNUC_VERSION}" ]]; then
    base_CFLAGS+=" -fgnuc-version=${GNUC_VERSION}"
fi

base_CXXFLAGS="${base_CFLAGS}"

if [[ -n "${CUSTOM_CXXFLAGS}" ]]; then
    base_CXXFLAGS+=" ${CUSTOM_CXXFLAGS}"
fi

x86_64_pc_linux_gnu_CFLAGS="${base_CFLAGS}"
x86_64_pc_linux_gnu_CXXFLAGS="${base_CXXFLAGS}"
x86_64_pc_linux_gnu_LDFLAGS="${base_LDFLAGS}"

i686_pc_linux_gnu_CFLAGS="${base_CFLAGS}"
i686_pc_linux_gnu_CXXFLAGS="${base_CXXFLAGS}"
i686_pc_linux_gnu_LDFLAGS="${base_LDFLAGS}"

RUSTFLAGS="-C target-cpu=native -C opt-level=3"
