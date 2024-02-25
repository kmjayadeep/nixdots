#!/usr/bin/env sh

# Terminate already running bar instances
# killall -q polybar  # didn't work
kill -9 $(pgrep -f 'polybar/config.ini') >/dev/null 2>&1


# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done


# Launch bar1 and bar2
for m in $(polybar --list-monitors | cut -d":" -f1); do
    # MONITOR=$m polybar --reload bottom --config=~/.config/polybar/config.ini &
    MONITOR=$m polybar --reload top --config=~/.config/polybar/config.ini &
done

echo "Bars launched..."
