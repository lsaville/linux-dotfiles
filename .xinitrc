dunst -conf "$HOME/.config/dunst/dunstrc" &
dropbox &
setxkbmap -option ctrl:nocaps
xinput set-prop 10 285 1
xinput set-prop 10 277 1

xautolock -time 15 -locker "i3lock" -detectsleep &

exec i3
