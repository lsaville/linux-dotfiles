dunst -conf "$HOME/.config/dunst/dunstrc" &
dropbox &
setxkbmap -option ctrl:nocaps
###########
# mouse
###########
# natural scrolling
xinput set-prop 10 277 1
# speed
xinput set-prop 11 284 1
###########
# track pad
###########
# tapping
xinput set-prop 11 293 1
# natural scrolling
xinput set-prop 11 277 1
# speed
xinput set-prop 11 284 1

xautolock -time 5 -locker "i3lock" -detectsleep &

exec i3
