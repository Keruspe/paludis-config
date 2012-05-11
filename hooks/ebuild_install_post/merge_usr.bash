apply_move() {
    pushd "${1}"
    for f in *; do
        if [[ ! -f "${2}/${f}" && ! -d "${2}/${f}" && ! -L "${2}/${f}" ]]; then
            mv "${f}" "${2}"
        elif [[ -d "${f}" && -d "${2}/${f}" ]]; then
            apply_move "${1}/${f}" "${2}/${f}"
        elif [[ ! -L "${f}" ]]; then
            mv "${f}" "${2}"
        elif [[ -L "${2}/${f}" ]]; then
            rm "${2}/${f}"
            mv "${f}" "${2}"
        else
            rm -r "${f}"
        fi
    done
    popd
    rmdir "${1}"
}

einfo_unhooked "Applying usr merge"

for dir in bin sbin lib lib32 lib64; do
    local slashdir="${IMAGE}"/${dir}/
    if [[ -d "${slashdir}" ]]; then
        local usrdir="${IMAGE}"/usr/${dir}/
        if [[ -d "${usrdir}" ]]; then
	    apply_move "${slashdir}" "${usrdir}"
        else
            mkdir -p "${IMAGE}"/usr/
            mv "${slashdir}" "${usrdir}"
        fi
    fi
done

local usrdir="${IMAGE}"/usr/etc/
if [[ -d "${usrdir}" ]]; then
    local slashdir="${IMAGE}"/etc/
    if [[ -d "${slashdir}" ]]; then
        apply_move "${usrdir}" "${slashdir}"
    else
        mv "${usrdir}" "${slashdir}"
    fi
fi
