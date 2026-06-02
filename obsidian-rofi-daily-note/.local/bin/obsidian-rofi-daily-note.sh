#!/usr/bin/env bash

DIR="/mnt/Projects/Notes/Shiplog/01-Journal/Daily"

FILE="$DIR/$(date +%F).md"
TEXT=$(rofi -dmenu -p "Daily note")

[ -z "$TEXT" ] && exit 0

mkdir -p "$DIR"

{
    echo "- ($(date +'%H:%M')) $TEXT"
} >> "$FILE"
