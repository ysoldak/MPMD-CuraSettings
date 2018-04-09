#!/bin/bash

VERSION=${1:-3.2}

pgrep -q cura
if [ "$?" == "0" ]; then
    echo "Cura is running, exit and run this script again"
    exit 1
fi

CURA_HOME="${HOME}/Library/Application Support/cura/${VERSION}"

echo "Uninstalling machine from cura dir: ${CURA_HOME}"

echo "  > Removing definition"
rm -f "${CURA_HOME}/definitions/monoprice_mini_delta.def.json"

echo "  > Removing start and end codes"
rm -f "${CURA_HOME}/definition_changes/Monoprice+Mini+Delta_settings.inst.cfg"
rm -f "${CURA_HOME}/definition_changes/Monoprice+Mini+Delta+fdmextruder_settings.inst.cfg"

echo "  > Removing build platform mesh"
rm -f "${CURA_HOME}/meshes/monoprice_mini_delta_platform.stl"

echo "  > Removing machine instance"
rm -f "${CURA_HOME}/machine_instances/Monoprice+Mini+Delta.global.cfg"

echo "  > Removing extruder configuration"
rm -f "${CURA_HOME}/extruders/Monoprice+Mini+Delta+fdmextruder.extruder.cfg"

echo "  > Removing user settings"
rm -f "${CURA_HOME}/user/Monoprice+Mini+Delta_user.inst.cfg"
rm -f "${CURA_HOME}/user/Monoprice+Mini+Delta+fdmextruder_user.inst.cfg"

echo "Done!"