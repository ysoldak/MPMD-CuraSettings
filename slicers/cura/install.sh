#!/bin/bash

VERSION=${1:-3.2}

pgrep -q cura
if [ "$?" == "0" ]; then
    echo "Cura is running, exit and run this script again"
    exit 1
fi

CURA_HOME="${HOME}/Library/Application Support/cura/${VERSION}"

echo "Installing machine into cura dir: ${CURA_HOME}"

echo "  > Adding definition"
mkdir -p "${CURA_HOME}/definitions"
cp ./definitions/*.json        "${CURA_HOME}/definitions/"

echo "  > Adding start and end codes"
mkdir -p "${CURA_HOME}/definition_changes"
cp ./definition_changes/*.cfg  "${CURA_HOME}/definition_changes/"

echo "  > Adding build platform mesh"
mkdir -p "${CURA_HOME}/meshes"
cp ./meshes/*.stl              "${CURA_HOME}/meshes/"

echo "  > Adding machine instance"
cp ./machine_instances/*.cfg "${CURA_HOME}/machine_instances/"

echo "  > Adding extruder configuration"
cp ./extruders/*.cfg "${CURA_HOME}/extruders/"

echo "  > Adding user settings (preserves existing)"
cp -n ./user/*.cfg "${CURA_HOME}/user/"

echo "Done!"