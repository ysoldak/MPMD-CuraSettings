#!/bin/bash

VERSION=${1:-3.2}

pgrep -q cura
if [ "$?" == "0" ]; then
    echo "Cura is running, exit and run this script again"
    exit 1
fi

# TODO make work on linux also
CURA_HOME="${HOME}/Library/Application Support/cura/${VERSION}"

echo "Installing machine into cura dir: ${CURA_HOME}"

for file in `find -E . -regex ".*\.(cfg|stl|json)"`; do
    dirname=`dirname $file | sed s,\./,,`
    basename=`basename $file`
    echo "Installing ${basename}"
    mkdir -p "${CURA_HOME}/${dirname}"
    if [ "${dirname}" == "definition_changes" ]; then
        # force install start/end gcode definitions
        cp "`pwd`/${dirname}/${basename}" "${CURA_HOME}/${dirname}/${basename}"
    else
        # do not overwrite file at destination to preserve user settings, quality selected, etc
        cp -n "`pwd`/${dirname}/${basename}" "${CURA_HOME}/${dirname}/${basename}"
    fi
    # Linking does not work since Cura re-creates configuration files instead of updating them
    #ln -s `pwd`/${dirname}/${basename} "${CURA_HOME}/${dirname}/${basename}"
done

echo "Done!"