#!/bin/sh

# Script template from
# https://frdmtoplay.com/i3-udev-xrandr-hotplugging-output-switching/

# Get out of town if something errors
set -e

# not used
# HDMI1_STATUS=$(</sys/class/drm/card0/card0-HDMI-A-1/status )
HDMI2_STATUS=$(</sys/class/drm/card0/card0-HDMI-A-2/status )
DP_STATUS=$(</sys/class/drm/card0/card0-DP-1/status )
eDP_STATUS=$(</sys/class/drm/card0/card0-eDP-1/status )

# this doesn't work
# /usr/bin/notify-send "HDMI_STATUS is: $HDMI2_STATUS"
# /usr/bin/notify-send "DP_STATUS is: $DP_STATUS"
# /usr/bin/notify-send "eDP_STATUS is: $eDP_STATUS"

#mbo
# rowing
# xrandr --output HDMI2 --primary --auto --output eDP1 --off

# office
# xrandr --output DP1 --primary --auto --mode 3840x1600 --output eDP1 --off

#mso
# rowing
# xrandr --output HDMI2 --off --output eDP1 --primary --auto

# office
# xrandr --output DP1 --off --output eDP1 --primary --auto

if [ "connected" == "$HDMI2_STATUS" ]; then
  /usr/bin/xrandr --output HDMI2 --primary --auto --output eDP1 --off
  /usr/bin/notify-send --urgency=low -t 5000 "Graphics Update" "HDMI2 plugged in"
elif [ "connected" == "$DP_STATUS" ]; then
  /usr/bin/xrandr --output DP1 --primary --auto --mode 3840x1600 --output eDP1 --off
  /usr/bin/notify-send --urgency=low -t 5000 "Graphics Update" "DP plugged in"
else 
  /usr/bin/xrandr --output HDMI2 --off
  /usr/bin/xrandr --output DP1 --off
  /usr/bin/xrandr --output eDP1 --primary --auto
	/usr/bin/notify-send --urgency=low -t 5000 "Graphics Update" "External monitor disconnected"	
	exit
fi
