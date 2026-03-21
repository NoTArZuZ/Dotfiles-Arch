#!/usr/bin/env bash

leftmb() {
	case $BLOCK_STATUS in
		0) ~/.config/slstatus/scripts/onclick/date curr & ;;
		1) ~/.config/slstatus/scripts/onclick/mem & ;;
		2) ~/.config/slstatus/scripts/onclick/cpu & ;;
		3) ~/.config/slstatus/scripts/onclick/diskfree & ;;
		4) ~/.config/slstatus/scripts/onclick/volume volume_mute & ;;
		5) ~/.config/slstatus/scripts/onclick/keymap & ;;
		6) ~/.config/slstatus/scripts/onclick/weather & ;;
		7) ~/.config/slstatus/scripts/onclick/run & ;;
		*) notify-send -i error "Dusk" "Invalid status ${BLOCK_STATUS} for button ${BLOCK_BUTTON}" & ;;
	esac
}

rightmb() {
	case $BLOCK_STATUS in
		4) ~/.config/slstatus/scripts/onclick/volume run_wiremix & ;;
	esac
}

mscrollup() {
	case $BLOCK_STATUS in
		0) ~/.config/slstatus/scripts/onclick/date next & ;;
		4) ~/.config/slstatus/scripts/onclick/volume volume_up & ;;
		*) notify-send -i error "Dusk" "Invalid status ${BLOCK_STATUS} for button ${BLOCK_BUTTON}" & ;;
	esac
}

mscrolldown() {
	case $BLOCK_STATUS in
		0) ~/.config/slstatus/scripts/onclick/date prev & ;;
		4) ~/.config/slstatus/scripts/onclick/volume volume_down & ;;
		*) notify-send -i error "Dusk" "Invalid status ${BLOCK_STATUS} for button ${BLOCK_BUTTON}" & ;;
	esac
}

case $BLOCK_BUTTON in
	1) leftmb ;;
	3) rightmb ;;
	4) mscrollup ;;
	5) mscrolldown ;;
	*) notify-send -i error "Dusk" "Invalid button ${BLOCK_BUTTON} for status ${BLOCK_STATUS}" & ;;
esac
