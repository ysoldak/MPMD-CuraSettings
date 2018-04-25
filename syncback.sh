#!/bin/bash

VERSION=${1:-3.3}
TYPE=${2:-all}

# -----------------------------------------------------------------------------

CURA_HOME=${CURA_HOME:-${HOME}"/Library/Application Support/cura"}
CURA_DIR="${CURA_HOME}/${VERSION}"

# -----------------------------------------------------------------------------

pgrep -q cura
if [ "$?" == "0" ]; then
    echo "Cura is running, exit and run this script again"
    exit 1
fi

# -----------------------------------------------------------------------------

echo "Syncing back machine changes from cura dir"
echo "   ${CURA_DIR}"
echo 

for file in `find -E . -regex ".*\.(cfg|stl|json)" | sort`; do
    dirname=`dirname $file | sed s,\./,,`
    basename=`basename $file`
    if [ "${TYPE}" == "all" ] || [ "${TYPE}" == "${dirname}" ]; then
        echo "  < ${basename}"
        cp "${CURA_DIR}/${dirname}/${basename}" "`pwd`/${dirname}/${basename}"
    else
        echo "  ~ ${basename}"
    fi
done

echo
echo "Done!"
