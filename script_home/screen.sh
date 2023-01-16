#!/bin/bash

output=`xrandr | grep "\bconnected\b" | cut -d' ' -f1`
xrandr --output $output --set TearFree on
