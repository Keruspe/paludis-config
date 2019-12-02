CHOST="x86_64-pc-linux-gnu"

base_CFLAGS="-march=native -pipe -O3"
base_LDFLAGS="-Wl,-O2,--as-needed"

# GCC-compat
GNUC_VERSION="6.5.0" # gcc 7 introduced _Float stuff
case "${CATEGORY}/${PN}" in
    "dev-libs/glib")
        # SEGV in g_thread when using e.g. appstream-glib => force gcc
        PATH="/usr/share/exherbo/banned_by_distribution:/etc/env.d/alternatives/cc/gcc/usr/${CHOST}/bin:/etc/env.d/alternatives/ld/gold/usr/${CHOST}/bin:${PATH}"
        GNUC_VERSION=""
        ;;
    "sys-apps/kexec-tools")
        # kexec-tools: error: unknown directive
        PATH="/usr/share/exherbo/banned_by_distribution:/etc/env.d/alternatives/cc/gcc/usr/${CHOST}/bin:${PATH}"
        GNUC_VERSION=""
        ;;
    "dev-util/elfutils"|"sys-boot/gnu-efi"|"sys-devel/gcc"|"sys-libs/glibc"|"sys-libs/libatomic"|"sys-libs/libgcc"|"sys-libs/libstdc++")
        # build system forces gcc
        GNUC_VERSION=""
        ;;
    "app-arch/gzip"|"app-arch/tar"|"app-editors/vim"|"app-editors/vim-runtime"|"app-spell/enchant"|"base/libatasmart"|"dev-lang/erlang"|"dev-lang/ruby"|"dev-libs/gtk-vnc"|"dev-libs/libsodium"|"dev-libs/popt"|"dev-libs/spidermonkey"|"gnome-desktop/GPaste"|"media-libs/libcanberra"|"media-libs/opus"|"media-sound/pulseaudio"|"net-misc/openssh"|"net-print/cups"|"net-scanner/nmap"|"net-www/firefox"|"sys-apps/accountsservice"|"sys-apps/coreutils"|"sys-apps/kbd"|"sys-apps/sed"|"sys-boot/dracut"|"sys-devel/gdb"|"sys-devel/m4"|"x11-libs/cairo")
        # erlang: configure fails
        # gcc:    random build failure
        # others: error: undefined symbol: __builtin_va_arg_pack  (introduced in gcc 4.3)
        GNUC_VERSION="4.2.4"
        ;;
    "sys-apps/systemd")
        # error: static_assert expression is not an integral constant expression
        GNUC_VERSION="4.5.4"
        ;;
esac
if [[ -n "${GNUC_VERSION}" ]]; then
    base_CFLAGS+=" -fgnuc-version=${GNUC_VERSION}"

    # Polly handling (clang-specific)
    case "${CATEGORY}/${PN}" in
        # libssh: configure fails to detect __func__
        # cmake:  configure fails silently
        "net-libs/libssh"|"sys-devel/cmake")
            ;;
        *)
            base_CFLAGS+=" -mllvm -polly"
            ;;
    esac
fi

# Custom {C,LD}FLAGS or linker
case "${CATEGORY}/${PN}" in
    "gnome-desktop/evince")
        base_CFLAGS+=" -Wno-format-nonliteral"
        ;;
    "gnome-desktop/gnome-builder")
        base_CFLAGS+=" -Wno-shadow"
        ;;
    "sys-apps/systemd")
        # otherwise sd-boot displays and does nothing
        EFI_LD="${CHOST}-ld.gold"
        ;;
    "sys-devel/gettext")
        # error: undefined symbol: sqrt
        base_LDFLAGS+=" -lm"
        ;;
    "x11-libs/cairo")
        # error: undefined reference to pthread_mutexattr_init
        base_LDFLAGS+=" -lpthread"
        ;;
esac

# LTO handling
case "${CATEGORY}/${PN}" in
    "dev-lang/erlang"|"dev-lang/perl"|"dev-lang/python"|"dev-libs/glib"|"dev-libs/libgcrypt"|"dev-libs/libglvnd"|"dev-util/elfutils"|"dev-util/strace"|"dev-util/valgrind"|"media-libs/x264"|"net-print/cups"|"sys-apps/fwupd"|"sys-devel/gcc"|"sys-devel/libostree"|"sys-libs/glibc"|"sys-libs/libgcc"|"x11-dri/mesa"|"x11-libs/pango")
        # erlang: fails at runtime (build elixir, rabbitmq)
        # fwupd:  fails at runtime to load modules
        # others: configure or build failure
        ;;
    *)
        if [[ -z "${PALUDIS_CROSS_COMPILE_HOST}" ]]; then
            base_CFLAGS+=" -flto=thin"
        elif [[ "${CATEGORY}/${PN}" != "dev-libs/icu" ]]; then
            base_CFLAGS+=" -flto=thin"
        fi
        ;;
esac

base_CXXFLAGS="${base_CFLAGS}"

# Custom CXXFLAGS
case "${CATEGORY}/${PN}" in
    "sys-auth/polkit")
        base_CXXFLAGS+=" -std=c++17"
        ;;
esac

x86_64_pc_linux_gnu_CFLAGS="${base_CFLAGS}"
x86_64_pc_linux_gnu_CXXFLAGS="${base_CXXFLAGS}"
x86_64_pc_linux_gnu_LDFLAGS="${base_LDFLAGS}"

i686_pc_linux_gnu_CFLAGS="${base_CFLAGS}"
i686_pc_linux_gnu_CXXFLAGS="${base_CXXFLAGS}"
i686_pc_linux_gnu_LDFLAGS="${base_LDFLAGS}"

RUSTFLAGS="-C target-cpu=native -C opt-level=3"
