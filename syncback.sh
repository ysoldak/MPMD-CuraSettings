#!/bin/bash

VERSION=${1:-3.2}

pgrep -q cura
if [ "$?" == "0" ]; then
    echo "Cura is running, exit and run this script again"
    exit 1
fi

# TODO make work on linux also
CURA_HOME="${HOME}/Library/Application Support/cura/${VERSION}"

echo "Syncing back machine changes from cura dir: ${CURA_HOME}"

for file in `find -E . -regex ".*\.(cfg|stl|json)"`; do
    dirname=`dirname $file | sed s,\./,,`
    basename=`basename $file`
    echo "Syncing ${basename}"
    cp "${CURA_HOME}/${dirname}/${basename}" "`pwd`/${dirname}/${basename}"
done

echo "Done!"
