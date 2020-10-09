dunst -conf "$HOME/.config/dunst/dunstrc" &
dropbox &
setxkbmap -option ctrl:nocaps
############
## mouse
############
## natural scrolling
#xinput set-prop 'Clearly Superior Technologies. CST Laser Trackball' 277 1
## speed
#xinput set-prop 'Clearly Superior Technologies. CST Laser Trackball' 284 1
############
## track pad
############
## tapping
#xinput set-prop 'DELL08AF:00 06CB:76AF Touchpad' 293 1
#xinput list-props 'DELL08AF:00 06CB:76AF Touchpad'
## natural scrolling
#xinput set-prop 'DELL08AF:00 06CB:76AF Touchpad' 277 1
## speed
#xinput set-prop 'DELL08AF:00 06CB:76AF Touchpad' 284 1
#
xautolock -time 5 -locker "i3lock" -detectsleep &

sudo mount -o remount,size=16G,noatime /tmp

exec i3
