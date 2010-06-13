CHOST="x86_64-pc-linux-gnu"
MAKEOPTS="-j5"
CFLAGS="-march=native -O2 -pipe"
CXXFLAGS="${CFLAGS}"
LDFLAGS="-Wl,-O2"

PATH="/usr/lib/ccache/bin:$PATH"
CCACHE_DIR="/var/tmp/ccache"
SANDBOX_WRITE="${SANDBOX_WRITE}:${CCACHE_DIR}"


if [[ "${CATEGORY}/${PN}" == "sys-apps/paludis" ]] ; then
    CXXFLAGS="${CXXFLAGS} -g -ggdb -ggdb3"
fi
