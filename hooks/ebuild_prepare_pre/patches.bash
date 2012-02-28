# vim: set sw=4 sts=4 et :

(
    cd "${WORK}"
    patchdir="/etc/paludis/autopatch/${CATEGORY}/${PN}"
    if [[ -d $patchdir ]] ; then
        einfo "Applying user patches"
        for p in $patchdir/*.patch ; do
            [[ -f "${p}" ]] || continue
            einfo "Applying $(basename ${p} )"
            patch -p1 < ${p} || exit 1
        done
        einfo "Done"
    fi
)
