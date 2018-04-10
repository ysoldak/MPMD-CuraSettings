#!/bin/bash

VERSION=${1:-3.2}

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

echo "Installing machine into cura dir"
echo "  ${CURA_DIR}"
echo

for file in `find -E . -regex ".*\.(cfg|stl|json)"`; do
    dirname=`dirname $file | sed s,\./,,`
    basename=`basename $file`
    mkdir -p "${CURA_DIR}/${dirname}"
    if [ "${dirname}" == "definition_changes" ]; then
        # force install start/end gcode definitions
        echo "  > ${basename}"
        cp "`pwd`/${dirname}/${basename}" "${CURA_DIR}/${dirname}/${basename}"
    else
        # do not overwrite file at destination to preserve user settings, quality selected, etc
        echo "  ? ${basename}"
        cp -n "`pwd`/${dirname}/${basename}" "${CURA_DIR}/${dirname}/${basename}"
    fi
    # Linking does not work since Cura re-creates configuration files instead of updating them
    #ln -s `pwd`/${dirname}/${basename} "${CURA_DIR}/${dirname}/${basename}"
done

echo
echo "Done!"
