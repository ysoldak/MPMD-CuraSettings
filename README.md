# Ultimaker Cura 3.2+ printer profile

My take on MPMD profile for Ultimaker Cura 3.2+.

Tested to be working with Cura 3.2 up to 3.4.1 and MPMD firmware v41.  
Be advised newer Mini Deltas (firmware v43) have improved stepper drivers with better resolution.  
Please use this [M92 line](https://github.com/ysoldak/MPMD-CuraSettings/blob/master/definition_changes/Monoprice%2BMini%2BDelta_settings.inst.cfg#L20) instead if you're using firmware 43 & up  
`M92 X114.28 Y114.28 Z114.28 E97.00`

Inspired by [Brian Corbino's Cura 3.2 profile](https://www.mpminidelta.com/slicers/cura)  
Inherits from [default Cura fdmprinter definition](https://github.com/Ultimaker/Cura/blob/master/resources/definitions/fdmprinter.def.json)

## Justification

While Brian Corbino's profile is good, it feels like many settings can be actually ommited, others adjusted.

Also, I've got tired of Cura 3.3 beta dropping my start/end gcodes all the time, so I wrote these scripts to be able track them with git and push to Cura when and if needed.

## Details

I've tried to keep definition short and to the point, and only hardware related things in there with couple of exceptions groupped at the end of the file.

Max values were learned from `M503` command, they somewhat differ from Brian's version -- quite lower. Feels safer to keep them to factory defaults and hopefully this improves time estimates in the slicer, when it knows the limits of the machine. Or, alternatively, if machine is capable of better, that new max values, probably, shall be set on both printer and slicer to match anyway.

[Start and End gcodes](definition_changes/Monoprice+Mini+Delta_settings.inst.cfg) are in separate `.cfg` file -- easier to edit them there. The drawback is this requies machine instance to be pre-configured on Cura, install script (see below) takes care of that.

## Usage

Use `install.sh` script on Mac to install printer definition on Cura 3.2 (by default) or pass version parameter.
Script adds machine instance for you, it shall appear in UI directly, with start and end codes configured.

(Symlinks may be a good alternative, instead of copying, to save on shell runs, but Cura re-creates files on update effectively deleting symlinks.)

Use `unistall.sh` script to remove everything MPMD related from Cura, not your quality customizations, though.

Use `syncback.sh` script to quickly pull your settings from Cura directory to save them in git or just locally.

## Start and End codes

`M92`, `M666` and `M665`  
First 3 lines of start gcode are calibration figures good for my machine, adjust for yours, links provided.

`M83`  
Start gcode uses [relative extrusion, a superior method of controlling extrusion](http://www.sublimelayers.com/2017/10/to-extruder-relative-or-not-to-extrude.html), that MPMD actually supports.
It's easier to do modifications to the script this way. It resets to absolute extrusion mode (`M82`) in the end.

`G28 X`  
Looks like bare `G28` confuses firmware sometimes and it thinks new print job starts on top of already running one, etc. I don't know, probably I'm just imagining things here, the code works, though, and as expected.

`M140`, `M190`, `M104` and `M109` templated  
Nice trick that lets you place your pre-heat sequence in any place of your startup routine. Handy.

Rest is documented in the code itself and probably going to change form time to time, so no point to document it here.

## Extra

### Calibration

- [Advanced Delta Printer Calibration](https://www.thingiverse.com/thing:745523)
- [3D Benchy](https://www.thingiverse.com/thing:763622)
- [Overhang / Cooling Test](https://www.thingiverse.com/thing:2699454/)
- [Triffid Hunter's Calibration Guide](https://reprap.org/wiki/Triffid_Hunter%27s_Calibration_Guide)

### 3D print tips and troubleshooting

- [Mastering Cura](https://ultimaker.com/en/resources/21932-mastering-cura)
- [Print Faster](https://ultimaker.com/en/resources/21918-print-faster)
- [Relative extrusion](http://www.sublimelayers.com/2017/10/to-extruder-relative-or-not-to-extrude.html)
- [Retraction: Just say "No" to oozing](https://www.matterhackers.com/articles/retraction-just-say-no-to-oozing)
- [Troubleshooting by S3D](https://www.simplify3d.com/support/print-quality-troubleshooting/)
- [Best Support Settings for 3D Printing](https://www.instructables.com/id/Best-Support-Settings-for-3D-Printing/)
