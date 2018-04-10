#!/bin/bash

VERSION=${1:-3.2}

pgrep -q cura
if [ "$?" == "0" ]; then
    echo "Cura is running, exit and run this script again"
    exit 1
fi

CURA_HOME="${HOME}/Library/Application Support/cura/${VERSION}"

echo "Uninstalling machine from cura dir: ${CURA_HOME}"

for file in `find -E . -regex ".*\.(cfg|stl|json)"`; do
    dirname=`dirname $file | sed s,\./,,`
    basename=`basename $file`
    echo "Removing ${basename}"
    rm -f "${CURA_HOME}/${dirname}/${basename}"
done

echo "Done!"
