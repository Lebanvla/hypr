#!/bin/bash

# Футуристичный скрипт для отображения системной информации

# Цвета
BLUE='\033[1;34m'
CYAN='\033[1;36m'
GREEN='\033[1;32m'
MAGENTA='\033[1;35m'
RED='\033[1;31m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Функция для отображения информации
display_info() {
    while true; do
        clear
        
        echo -e "${CYAN}╔══════════════════════════════════════════════════════════╗${NC}"
        echo -e "${CYAN}║                 СИСТЕМНАЯ ИНФОРМАЦИЯ                     ║${NC}"
        echo -e "${CYAN}╚══════════════════════════════════════════════════════════╝${NC}"
        echo
        
        # Дата и время
        echo -e "${BLUE}  ДАТА И ВРЕМЯ:${NC}"
        echo -e "   ${WHITE}$(date '+%A, %d %B %Y | %H:%M:%S')${NC}"
        echo
        
        # Загрузка системы
        echo -e "${BLUE}  ЗАГРУЗКА СИСТЕМЫ:${NC}"
        echo -e "   ${WHITE}CPU: $(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}')${NC}"
        echo -e "   ${WHITE}Память: $(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }') ($(free -m | awk 'NR==2{printf "%sMB/%sMB", $3,$2 }'))${NC}"
        echo -e "   ${WHITE}Диск: $(df -h / | awk 'NR==2{print $5}') заполнено${NC}"
        echo
        
        # Сеть
        echo -e "${BLUE}  СЕТЬ:${NC}"
        if [ $(nmcli -t -f TYPE dev | grep -c wifi) -gt 0 ]; then
            echo -e "   ${WHITE}Wi-Fi: $(nmcli -t -f ACTIVE,SSID dev wifi | grep '^yes' | cut -d: -f2)${NC}"
        fi
        echo -e "   ${WHITE}IP: $(hostname -I | awk '{print $1}')${NC}"
        echo
        
        # Батарея (если есть)
        if [ -d /sys/class/power_supply/BAT0 ]; then
            echo -e "${BLUE}  БАТАРЕЯ:${NC}"
            echo -e "   ${WHITE}$(cat /sys/class/power_supply/BAT0/capacity)% ($(cat /sys/class/power_supply/BAT0/status))${NC}"
            echo
        fi
        
        # Температура
        if [ -f /sys/class/thermal/thermal_zone0/temp ]; then
            echo -e "${BLUE}  ТЕМПЕРАТУРА:${NC}"
            echo -e "   ${WHITE}$(($(cat /sys/class/thermal/thermal_zone0/temp) / 1000))°C${NC}"
            echo
        fi
        
        # Активные окна
        echo -e "${BLUE}  АКТИВНЫЕ ОКНА:${NC}"
        hyprctl clients | grep -E "class|title" | awk -F: '{print $2}' | sed 's/^ //' | paste -d " " - - | head -5 | while read line; do
            echo -e "   ${WHITE} $line${NC}"
        done
        
        sleep 2
    done
}

# Запуск отображения информации
display_info