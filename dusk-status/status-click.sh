#!/usr/bin/env bash

leftmb() {
	case $BLOCK_STATUS in
		0) ~/dusk-status/onclick/date & ;;
		1) ~/dusk-status/onclick/mem & ;;
		2) ~/dusk-status/onclick/cpu & ;;
		3) ~/dusk-status/onclick/diskfree & ;;
		4) ~/dusk-status/onclick/volume & ;;
		5) ~/dusk-status/onclick/keymap & ;;
		*) notify-send -i error "Dusk" "Invalid status $BLOCK_STATUS"
	esac
}

case $BLOCK_BUTTON in
	1) leftmb ;;
	*) notify-send -i error "Dusk" "No function available for Button ${BLOCK_BUTTON} yet" & ;;
esac
