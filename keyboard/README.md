# Macropad things

The VIA keyboard layout configuration file contains the configuration and macros for the Framework 16 macropad that work in tandem with the sway configuration.

The top buttons set the layer. A single press will only set the layer for the next keypress. That means if you want to change the power mode, you can press top button 2 and then the correct power mode, then the macropad will go back to just being a numpad. If you want to stay in that layer, you can press the top button twice.

| A| B| C| D|
|--|--|--|--|
| 1| 2| 3| 4|
| 5| 6| 7| 8|
| 9|10|11|12|
|13|14|15|16|
|17|18|19|20|

Examples:
B + 1 = Change to power save mode, then return to numpad
B + B = Change to Layer 1 (system macros). Do NOT return to numpad.


## Layers

### Layer 0: RGB + Numpad

Activate with: A

When numlock is off, this will control RGB controls. 4 will toggle RGB on and off.

When numblock is on, this will act as a regular numpad

### Layer 1: System macros

Activate with: B

#### Power profiles

1 = Power save mode
2 = Balanced power mode
3 = Performance power mode
4 = Disable screen timeout

#### Default audio out

5 = Focusrite Scarlett 2i2
6 = Speakers
7 = HDMI
8 = Audio jack

### Layer 2: Discord

Activate with: C

1 = Mute
2 = Deafen
3 = Disconnect

These are literally mapped to F13, F14, and F15. You'll have to configure discord to use these F keys for the respective hotkey. Or change them up, I don't care, I'm not your dad.

## To do

Make pretty lights do things. If I understand correctly, that requires programming and flashing QMK firmware stuff. And that's just too much effort, I don't have time for that right now :/
