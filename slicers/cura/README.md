# Ultimaker Cura 3.2+ printer profile

Inspired by [Brian Corbino's Cura 3.2 profile](https://www.mpminidelta.com/slicers/cura)
Inherits from [default Cura fdmprinter definition](https://github.com/Ultimaker/Cura/blob/master/resources/definitions/fdmprinter.def.json)

## Justification

While Brian Corbino's profile is good, it's a bit big and feels like many settings can be actually ommited, others adjusted.

Also, I've got tired of Cura 3.3beta dropping my start/end gcodes all the time, so I wrote these scripts to be able track them with git and push to Cura when and if needed.

## Usage

Use `install.sh` script on Mac to install printer definition and instance on Cura 3.2 (by default) or pass version parameter.
You don't need to go there and add that printer manually, shall appear in UI directly, with start and end codes configured.

May symlink, instead of copying, to save on shell runs, but not sure how Cura reacts if file got changed while it's running.

Use `unistall.sh` script to remove everything MPMD related from Cura.

## Start and End codes

`M92`, `M666` and `M665`  
First 3 lines of start gcode are calibration figures good for my machine, adjust for yours, links provided.

`M83`  
Codes use relative extrusion, a superior method of controlling extrusion, that MPMD actually supports, but you are free to switch back to absolute extrusion in the print options -- start gcode zeroes extrusion length, so no worries.

`G28 X`  
Looks like bare `G28` confuses firmware sometimes and it thinks new print job starts on top of already running one, etc. I don't know, probably I'm just imagining things here, the code works, though, and as expected.

`M140`, `M190`, `M104` and `M109` templated  
Learned this trick toying with codes for Prusa MK3, so basically you can place your pre-heat sequence in any place of your startup routine. Handy.

Rest is documented in the code itself and probably going to change form time to time, so no point to document it here.
