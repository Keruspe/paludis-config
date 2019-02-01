# vim: set sw=4 sts=4 et :

(
    edo pushd "${MESON_SOURCE:-${WORK}}"
    patchdir="/etc/paludis/autopatch/${CATEGORY}/${PN}"
    if [[ -d "${patchdir}" ]] ; then
        einfo "Applying user patches"
        for p in "${patchdir}"/*.patch ; do
            [[ -f "${p}" ]] || continue
            einfo "Applying $(basename ${p} )"
            edo cat "${p}" | patch -s -f -p1
        done
        einfo "Done"
    fi
    edo popd
)
