CHOST="x86_64-pc-linux-gnu"
x86_64_pc_linux_gnu_CFLAGS="-march=native -pipe -O2"
x86_64_pc_linux_gnu_CXXFLAGS="${x86_64_pc_linux_gnu_CFLAGS}"
x86_64_pc_linux_gnu_LDFLAGS="-Wl,-O2 -Wl,--as-needed"

case "${CATEGORY}/${PN}" in
    "sys-apps/paludis")
        x86_64_pc_linux_gnu_CXXFLAGS="-march=native -pipe -O0 -g -ggdb3"
        x86_64_pc_linux_gnu_CFLAGS="${x86_64_pc_linux_gnu_CXXFLAGS}"
        ;;
    "dev-lang/node"|"net-www/nightly")
        x86_64_pc_linux_gnu_CXXFLAGS="-march=native -pipe -O1"
        x86_64_pc_linux_gnu_CXXFLAGS+=" -g -ggdb3"
        x86_64_pc_linux_gnu_CFLAGS="${x86_64_pc_linux_gnu_CXXFLAGS}"
        ;;
    "sys-devel/gcj")
        x86_64_pc_linux_gnu_LDFLAGS="-Wl,-O2"
        ;;
esac
