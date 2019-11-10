CHOST="x86_64-pc-linux-gnu"

base_CFLAGS="-march=native -pipe -O2"
base_LDFLAGS="-Wl,-O1 -Wl,--as-needed"

CUSTOM_CXXFLAGS=""

# glibc requires manual "eclectic ld set gold"
# libxml2 fails to cross compile because of some relocation of a glibc symbols
# SDL is stupid and requires libunwind pkg-config files when libunwind.h is present
# firefox: error: no member named 'abort' in namespace 'std::__1'; did you mean simply 'abort'?

# undefied symbol g_paste_settings_get_type
case "${CATEGORY}/${PN}" in
    "gnome-desktop/GPaste")
        base_CFLAGS+=" -fuse-ld=gold"
        ;;
esac

# SEGV in g_thread when using e.g. appstream-glib
case "${CATEGORY}/${PN}" in
    "dev-libs/glib")
        PATH="/usr/share/exherbo/banned_by_distribution:/etc/env.d/alternatives/cc/gcc/usr/${CHOST}/bin:/etc/env.d/alternatives/ld/gold/usr/${CHOST}/bin:${PATH}"
        ;;
esac

# spidermonkey: missing symbols when built with clang. fixed in 70+?
# polkit:       error: statement not allowed in constexpr constructor
case "${CATEGORY}/${PN}" in
    "dev-libs/spidermonkey"|"sys-auth/polkit")
        PATH="/usr/share/exherbo/banned_by_distribution:/etc/env.d/alternatives/cc/gcc/usr/${CHOST}/bin:/etc/env.d/alternatives/c++/gcc/usr/${CHOST}/bin:${PATH}"
        CUSTOM_CXXFLAGS="-nostdinc++ -I/usr/include/c++/v1"
        base_LDFLAGS+=" -nodefaultlibs -lc++ -lc++abi -lm -lc"
        ;;
esac

# elfutils:       error: gcc with GNU99 support required
# v4l-utils:      error: function definition is not allowed here
# NetworkManager: ERROR: Assert failed: Unused symbol eviction requested but not supported. Use -Dld_gc=false to build without it.
# kexec-tools:    error: unknown directive
# efibootmgr:     No rule to make target 'efivar.h', needed by 'efibootmgr.o'.  Stop.
# libatomic:      error: no 8-bit type, please report a bug
case "${CATEGORY}/${PN}" in
    "dev-util/elfutils"|"media-libs/v4l-utils"|"net-apps/NetworkManager"|"sys-apps/kexec-tools"|"sys-boot/efibootmgr"|"sys-libs/libatomic")
        PATH="/usr/share/exherbo/banned_by_distribution:/etc/env.d/alternatives/cc/gcc/usr/${CHOST}/bin:${PATH}"
        ;;
esac

# links to libstdc++ otherwise
case "${CATEGORY}/${PN}" in
    "dev-util/elfutils")
        CUSTOM_CXXFLAGS="-nostdinc++ -I/usr/include/c++/v1"
        base_LDFLAGS+=" -nodefaultlibs -lc++ -lc++abi -lm -lc"
        ;;
esac

# error: undefined symbol: pthread_once
case "${CATEGORY}/${PN}" in
    "media-libs/v4l-utils")
        base_LDFLAGS+=" -lpthread"
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
x86_64_pc_linux_gnu_CXXFLAGS="${base_CFLAGS} ${CUSTOM_CXXFLAGS}"
x86_64_pc_linux_gnu_LDFLAGS="${base_LDFLAGS}"

i686_pc_linux_gnu_CFLAGS="${base_CFLAGS}"
i686_pc_linux_gnu_CXXFLAGS="${base_CFLAGS} ${CUSTOM_CXXFLAGS}"
i686_pc_linux_gnu_LDFLAGS="${base_LDFLAGS}"

RUSTFLAGS="-C target-cpu=native -C opt-level=3"
