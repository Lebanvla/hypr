#!/bin/bash

# Скрипт для динамического обновления Waybar

while true; do
    # Обновление Waybar каждые 5 секунд
    pkill -RTMIN+1 waybar
    sleep 5
done