#!/usr/bin/env fish

set -l prev_state up
set -l next_state up
set -l play_state up
set -l ignore_play_up no

while true
	set -l Event (cat /home/me/Documents/Input/key_event_fifo)

	echo $Event | read -d ':' -l Key State
	set $Key'_state' $State

	if test $play_state = down
		if test $prev_state = down
			set ignore_play_up yes
			playerctl volume 0.03-
		else if test $next_state = down
			set ignore_play_up yes
			playerctl volume 0.03+
		end
	else if test $Key = play -a $State = up
		if test $ignore_play_up != yes
			playerctl play-pause
		end
		
		set ignore_play_up no
	else if test $prev_state = down
		playerctl previous
	else if test $next_state = down
		playerctl next
	end
end
