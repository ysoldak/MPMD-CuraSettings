#!/bin/bash

VERSION=${1:-3.2}

pgrep -q cura
if [ "$?" == "0" ]; then
    echo "Cura is running, exit and run this script again"
    exit 1
fi

# TODO make work on linux also
CURA_HOME="${HOME}/Library/Application Support/cura/${VERSION}"

echo "Uninstalling machine from cura dir"
echo "  ${CURA_HOME}"
echo

for file in `find -E . -regex ".*\.(cfg|stl|json)"`; do
    dirname=`dirname $file | sed s,\./,,`
    basename=`basename $file`
    echo "  x ${basename}"
    rm -f "${CURA_HOME}/${dirname}/${basename}"
done

echo
echo "Done!"
