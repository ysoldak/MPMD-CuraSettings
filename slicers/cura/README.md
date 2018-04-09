# Ultimaker Cura 3.2+ printer profile

Inspired by [Brian Corbino's Cura 3.2 profile](https://www.mpminidelta.com/slicers/cura)
Inherits from [default Cura fdmprinter definition](https://github.com/Ultimaker/Cura/blob/master/resources/definitions/fdmprinter.def.json)

## Justification

While Brian Corbino's profile is good, it's a bit big and feels like many settings can be actually ommited, others adjusted.

Also, I've got tired of Cura 3.3beta dropping my start/end gcodes all the time, so I wrote these scripts to be able track them with git and push to Cura when and if needed.

## Details

I've tried to keep definition short and to the point, and only hardware related things in there with couple of exceptions groupped at the end of the file.
Max values were learned from `M503` command, they somewhat differ from Brian's version -- quite lower. Feels safer to keep them to factory defaults and hopefully this improves time estimates in the slicer, when it knows the limits of the machine. Or, alternatively, if machine is capable of better, that new max values, probably, shall be set on both printer and slicer to match anyway.
Start and End gcodes are in separate `.cfg` file -- easier to edit them there. The drawback is this requies machine instance to be pre-configured on Cura, install script (see below) takes care of this.

## Usage

Use `install.sh` script on Mac to install printer definition and instance on Cura 3.2 (by default) or pass version parameter.
You don't need to go there and add that printer manually, shall appear in UI directly, with start and end codes configured.

Symlinks may also work, instead of copying, to save on shell runs, but not sure how Cura reacts if file got changed while it's running.

Use `unistall.sh` script to remove everything MPMD related from Cura, not your quality customizations, though.

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
