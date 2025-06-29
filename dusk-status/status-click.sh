#!/usr/bin/env bash

leftmb() {
	case $BLOCK_STATUS in
		0) ~/dusk-status/onclick/date & ;;
		1) ~/dusk-status/onclick/mem & ;;
		2) ~/dusk-status/onclick/cpu & ;;
		3) ~/dusk-status/onclick/diskfree & ;;
		4) ~/dusk-status/onclick/volume & ;;
		5) ~/dusk-status/onclick/keymap & ;;
		*) notify-send -i error "Dusk" "Invalid status ${BLOCK_STATUS} for button ${BLOCK_BUTTON}" & ;;
	esac
}

scrollup() {
	case $BLOCK_STATUS in
		4) ~/dusk-status/onclick/plusvolume & ;;
		*) notify-send -i error "Dusk" "Invalid status ${BLOCK_STATUS} for button ${BLOCK_BUTTON}" & ;;
	esac
}

scrolldown() {
	case $BLOCK_STATUS in
		4) ~/dusk-status/onclick/minusvolume & ;;
		*) notify-send -i error "Dusk" "Invalid status ${BLOCK_STATUS} for button ${BLOCK_BUTTON}" & ;;
	esac
}

case $BLOCK_BUTTON in
	1) leftmb ;;
	4) scrollup ;;
	5) scrolldown ;;
	*) notify-send -i error "Dusk" "Invalid button ${BLOCK_BUTTON} for status ${BLOCK_STATUS}" & ;;
esac
