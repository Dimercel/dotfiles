setxkbmap -layout "us,ru" -option "grp:caps_toggle"
sh ~/.fehbg &
exec ck-launch-session dbus-launch --sh-syntax --exit-with-session awesome
