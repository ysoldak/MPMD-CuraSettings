#!/bin/bash

VERSION=${1:-3.3}

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

echo "Uninstalling machine from cura dir"
echo "  ${CURA_DIR}"
echo

for file in `find -E . -regex ".*\.(cfg|stl|json)"`; do
    dirname=`dirname $file | sed s,\./,,`
    basename=`basename $file`
    echo "  x ${basename}"
    rm -f "${CURA_DIR}/${dirname}/${basename}"
done

echo
echo "Done!"
