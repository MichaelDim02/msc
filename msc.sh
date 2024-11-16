#!/bin/bash

primary="LVDS-1"

dp=$(xrandr | grep " connected" | cut -d" " -f1 | grep -v $primary | dmenu -p "Monitor")

res=$(xrandr | grep $dp -A 1 | tail -1 | tr -s " " | cut -d" " -f2)

rot=$(printf "normal\nleft\nright\ninverted\ncancel" | dmenu -p "Rotation")
if [ "$rot" == "cancel" ]; then exit 0; fi

rl=$(printf "normal\nright\nleft\nmirror\ncancel" | dmenu -p "Relation")
if [ "$rl" == "cancel" ]; then exit 0; fi

if [ "$rl" == "normal" ]; then
	xrandr --output $dp --mode "$res" --rotate $rot
elif [ "$rl" == "mirror" ]; then
	#dp1=$(xrandr | grep " connected" | cut -d" " -f1 | dmenu | grep -v $dp)
	#xrandr --output $dp --mode "$res" --rotate $rot --same-as $dp1
	xrandr --output $dp --mode "$res" --rotate $rot --same-as $primary
else
	#dp1=$(xrandr | grep " connected" | cut -d" " -f1 | dmenu | grep -v $dp)
	#xrandr --output $dp --mode "$res" --rotate $rot --"${rl}"-of $dp1
	xrandr --output $dp --mode "$res" --rotate $rot --"${rl}"-of $primary
fi
