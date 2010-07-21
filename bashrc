CHOST="x86_64-pc-linux-gnu"
MAKEOPTS="-j5"
CFLAGS="-march=native -O2 -pipe -g -ggdb"
CXXFLAGS="${CFLAGS}"
LDFLAGS="-Wl,-O2 -Wl,--as-needed"

if [[ "${CATEGORY}/${PN}" == "sys-apps/paludis" ]] ; then
    CXXFLAGS="${CXXFLAGS} -ggdb3"
fi

if [[ "${CATEGORY}/${PN}" == "dev-python/docutils" ]] ; then
    LC_ALL="fr_FR.UTF-8"
fi
