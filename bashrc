CHOST="x86_64-pc-linux-gnu"

base_CFLAGS="-march=native -pipe -O2"
base_LDFLAGS="-Wl,-O2 -Wl,--as-needed"

case "${CATEGORY}/${PN}" in
    "sys-apps/paludis")
        base_CFLAGS="-march=native -pipe -O0 -g -ggdb3"
        ;;
    "dev-lang/node"|"net-www/nightly")
        base_CFLAGS="-march=native -pipe -O0"
        ;;
    "sys-devel/gcj")
        base_LDFLAGS="-Wl,-O2"
        ;;
esac

x86_64_pc_linux_gnu_CFLAGS="${base_CFLAGS}"
x86_64_pc_linux_gnu_CXXFLAGS="${base_CFLAGS}"
x86_64_pc_linux_gnu_LDFLAGS="${base_LDFLAGS}"
