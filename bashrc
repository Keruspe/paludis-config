CHOST="x86_64-pc-linux-gnu"
LDFLAGS="-Wl,-O2"
MAKEOPTS="-j5"
PATH="/usr/lib/ccache/bin:$PATH"
CCACHE_DIR="/var/tmp/ccache"
SANDBOX_WRITE="${SANDBOX_WRITE}:${CCACHE_DIR}"

CFLAGS="-march=native -O2 -pipe"
CXXFLAGS="${CFLAGS}"

if [[ "${CATEGORY}/${PN}" == "sys-apps/paludis" ]] ; then
    CXXFLAGS="${CXXFLAGS} -g -ggdb -ggdb3"
fi
