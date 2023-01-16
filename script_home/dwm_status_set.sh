#!/bin/bash

p_date(){
	date '+%l:%M %a'
}

#xsetroot
xsetroot -name "$(p_date) "
exit 0
