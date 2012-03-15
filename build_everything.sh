#!/bin/sh
rm Everything.sml
preml MyLib.mlb
preml Everything.inc -o Everything.sml
preml Everything.sml -o Everything.sml
preml MyLib.mlb -c