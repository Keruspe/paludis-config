CHOST="x86_64-pc-linux-gnu"
LDFLAGS="-Wl,-O2"
MAKEOPTS="-j5"
PATH="/usr/lib/ccache/bin:$PATH"
CCACHE_DIR="/var/tmp/ccache"
SANDBOX_WRITE="${SANDBOX_WRITE}:${CCACHE_DIR}"

CFLAGS="-march=core2 -msse4 -maes -mpclmul -mpopcnt -mcx16 -msahf -mtune=core2 -O2 -pipe"
CXXFLAGS="${CFLAGS}"
