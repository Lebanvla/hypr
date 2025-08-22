#!/bin/bash
options="Выключить\nПерезагрузить\nСпящий режим\nВыйти"
chosen=$(echo -e "$options" | wofi --dmenu --prompt="Управление питанием:")

case "$chosen" in
    "Выключить") systemctl poweroff ;;
    "Перезагрузить") systemctl reboot ;;
    "Спящий режим") systemctl suspend ;;
    "Выйти") hyprctl dispatch exit ;;
esac