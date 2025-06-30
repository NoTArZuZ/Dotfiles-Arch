#!/usr/bin/env bash

leftmb() {
	case $BLOCK_STATUS in
		0) ~/slstatus-sus/scripts/onclick/date & ;;
		1) ~/slstatus-sus/scripts/onclick/mem & ;;
		2) ~/slstatus-sus/scripts/onclick/cpu & ;;
		3) ~/slstatus-sus/scripts/onclick/diskfree & ;;
		4) ~/slstatus-sus/scripts/onclick/volume & ;;
		5) ~/slstatus-sus/scripts/onclick/keymap & ;;
		*) notify-send -i error "Dusk" "Invalid status ${BLOCK_STATUS} for button ${BLOCK_BUTTON}" & ;;
	esac
}

mscrollup() {
	case $BLOCK_STATUS in
		4) ~/slstatus-sus/scripts/onclick/plusvolume & ;;
		*) notify-send -i error "Dusk" "Invalid status ${BLOCK_STATUS} for button ${BLOCK_BUTTON}" & ;;
	esac
}

mscrolldown() {
	case $BLOCK_STATUS in
		4) ~/slstatus-sus/scripts/onclick/minusvolume & ;;
		*) notify-send -i error "Dusk" "Invalid status ${BLOCK_STATUS} for button ${BLOCK_BUTTON}" & ;;
	esac
}

case $BLOCK_BUTTON in
	1) leftmb ;;
	4) mscrollup ;;
	5) mscrolldown ;;
	*) notify-send -i error "Dusk" "Invalid button ${BLOCK_BUTTON} for status ${BLOCK_STATUS}" & ;;
esac
