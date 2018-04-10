#!/bin/bash

VERSION=${1:-3.2}
TYPE=${2:-all}

pgrep -q cura
if [ "$?" == "0" ]; then
    echo "Cura is running, exit and run this script again"
    exit 1
fi

# TODO make work on linux also
CURA_HOME="${HOME}/Library/Application Support/cura/${VERSION}"

echo "Syncing back machine changes from cura dir"
echo "   ${CURA_HOME}"
echo 

for file in `find -E . -regex ".*\.(cfg|stl|json)" | sort`; do
    dirname=`dirname $file | sed s,\./,,`
    basename=`basename $file`
    if [ "${TYPE}" == "all" ] || [ "${TYPE}" == "${dirname}" ]; then
        echo "  < ${basename}"
        cp "${CURA_HOME}/${dirname}/${basename}" "`pwd`/${dirname}/${basename}"
    else
        echo "  ~ ${basename}"
    fi
done

echo
echo "Done!"
