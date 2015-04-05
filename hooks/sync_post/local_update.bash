#! /bin/bash

dir=/var/db/paludis/repositories/${TARGET}

[[ -d ${dir} ]] || exit 0

source "${PALUDIS_EBUILD_DIR}"/echo_functions.bash

pushd $dir &>/dev/null
for p in /etc/paludis/autopatch/${TARGET}/*.patch; do
   [[ -f ${p} ]] || continue
   if ! git am ${p}; then
       git am --abort
       ewarn Patch failed: ${p}
       exit 1
   fi
done
popd &>/dev/null

exit 0
