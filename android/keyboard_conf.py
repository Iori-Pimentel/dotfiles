from keyboard_lib import (
    update_key as KEY,
    update_row as ROW,
    update_keyboard as KEYBOARD,
    add_modifier as MODIFIER,
    insert_before as BEFORE,
    insert_after as AFTER,
    pretty_print as PRINT,
    pretty_copy as COPY,
)

# Settings
# Keyboard Height: 30%
# Horizontal Margin: 200dp
# Automatic Capitalization: Off

# Useful links
#   https://github.com/Julow/Unexpected-Keyboard/tree/master/doc
#   https://github.com/Julow/Unexpected-Keyboard/tree/master/res/xml/bottom_row.xml
#   https://github.com/Julow/Unexpected-Keyboard/tree/master/srcs%2Flayouts%2Flatn_qwerty_us.xml

QWERTY_US = ("qwertyuiop", "asdfghjkl", "zxcvbnm")
BOTTOM_ROW = ("ctrl", ".", "space", "arrows", "enter")

KEYBOARD(name="Termux Layout", bottom_row=False, locale_extra_keys=False)
KEYBOARD(*QWERTY_US, BOTTOM_ROW)

# Layout of Custom Keys
BEFORE(C="shift", on="z")
AFTER(C="backspace", on="m")
KEY(C=None, N="up", E="right", W="left", S="down", on="arrows")
KEY(shift=0.5, on="a")
KEY(width=1.5, on="shift")
KEY(width=1.5, on="backspace")
KEY(width=1.7, on="ctrl")
KEY(width=1.7, on="enter")
KEY(width=1.1, on=".")
KEY(width=1.1, on="up")
KEY(width=4.4, on="space")
ROW(height=0.95, on="space")

# Numbers
KEY(NW="0", on="q")
KEY(NW="1", on="w")
KEY(SW="2", on="w")
KEY(SE="3", on="w")
KEY(NW="4", on="e")
KEY(SW="5", on="e")
KEY(SE="6", on="e")
KEY(NW="7", on="r")
KEY(SW="8", on="r")
KEY(SE="9", on="r")

# Blocks and Quotes
KEY(NW="{", on="s")
KEY(NW="}", on="d")
KEY(SE="(", on="s")
KEY(SE=")", on="d")
KEY(SE="[", on="z")
KEY(SE="]", on="x")
KEY(NW="<", on="z")
KEY(NW=">", on="x")
KEY(SW="`", on="s")
KEY(SW='"', on="d")
KEY(SW="%", on="z")
KEY(SW="'", on="x")

# j/k Motions
KEY(SW="/", on="j")
KEY(SW="?", on="k")
KEY(SE=";", on="j")
KEY(SE=",", on="k")
KEY(NE="*", on="j")
KEY(NE="#", on="k")

# Pairs
KEY(SW="-", on="i")
KEY(SW="+", on="o")
KEY(NE="|", on="i")
KEY(NE="&", on="o")

# Shell Keys
KEY(SE="~", on="i")
KEY(SE="\\", on="o")
# Assignment Keys (Walrus Operator)
KEY(NE=":", on="n")
KEY(NE="=", on="m")
# Negation/XOR Keys
KEY(SW="!", on="m")
KEY(SW="^", on="n")
# Variable Access and Variable Name
KEY(SE="$", on="n")
KEY(SE="_", on="m")

# Miscellaneous
KEY(SE="@", on="q")

# Modifier/Custom Keys
KEY(SE="esc", on="a")
KEY(NW="tab", on="a")
KEY(NW="capslock", on="shift")
KEY(NE="delete", on="backspace")
KEY(SW="fn", SE="alt", on=".")
KEY(SE="config", NE="action", SW="switch_forward", NW="change_method", on="enter")
MODIFIER(shift="", fn="", ctrl="", on="capslock")

PRINT()
COPY()
