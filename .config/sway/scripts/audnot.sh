#!/bin/bash
sleep 0.05

makoctl dismiss --group volume_sh

# Get default sink
sink=$(pactl get-default-sink)

# Get volume level (number only)
volume=$(pactl get-sink-volume "$sink" | awk -F'/' '{gsub(/ /, "", $2); print $2}' | tr -d '%')

# Get mute status
muted=$(pactl get-sink-mute "$sink" | awk '{print $2}')

# Choose absolute icon path and message
if [ "$muted" = "yes" ]; then
  icon="/usr/share/icons/Papirus/24x24/actions/audio-volume-muted.svg"
  message="Muted"
else
  if [ "$volume" -ge 70 ]; then
    icon="/usr/share/icons/Papirus/24x24/actions/audio-volume-high.svg"
  elif [ "$volume" -ge 30 ]; then
    icon="/usr/share/icons/Papirus/24x24/actions/audio-volume-medium.svg"
  else
    icon="/usr/share/icons/Papirus/24x24/actions/audio-volume-low.svg"
  fi
  message="Volume: ${volume}%"
fi

# Send notification with absolute icon path
notify-send --app-name="volume_sh" -t 1000 -i "$icon" "$message"
