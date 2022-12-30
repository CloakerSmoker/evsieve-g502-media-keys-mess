#!/usr/bin/env fish

set -l Device '/dev/input/by-id/usb-Logitech_G502_HERO_Gaming_Mouse_0570307B3132-if01-event-kbd'
set -l ActionPrefix 'echo '
set -l ActionSuffix ' > /home/me/Documents/Input/key_event_fifo'

set -l Mappings 'key:nextsong=next' 'key:previoussong=prev' 'key:playpause=play'

set -l Hooks ''

for Mapping in $Mappings
	echo $Mapping | read -d '=' -l Key Action
	set Hooks $Hooks' --hook '$Key':0 exec-shell="'$ActionPrefix$Action':up'$ActionSuffix'"'
	set Hooks $Hooks' --hook '$Key':1 exec-shell="'$ActionPrefix$Action':down'$ActionSuffix'"'
end

echo $Hooks

echo evsieve --input $Device grab $Hooks | fish
