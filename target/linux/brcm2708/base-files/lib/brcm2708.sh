#!/bin/sh
# Copyright (C) 2015-2017 OpenWrt.org

ifname=""

brcm2708_detect() {
	local board_name model

	model=$(cat /proc/device-tree/model)
	case "$model" in
	"Raspberry Pi Model B Rev"*)
		board_name="rpi-b"
		;;
	"Raspberry Pi Model B Plus Rev"* |\
	"Raspberry Pi Model B+ Rev"*)
		board_name="rpi-b-plus"
		;;
	"Raspberry Pi Compute Module Rev"*)
		board_name="rpi-cm"
		;;
	"Raspberry Pi Zero Rev"*)
		board_name="rpi-zero"
		;;
	"Raspberry Pi 2 Model B Rev"*)
		board_name="rpi-2-b"
		;;
	"Raspberry Pi 3 Model B Rev"*)
		board_name="rpi-3-b"
		;;
	"Raspberry Pi Compute Module 3 Rev"*)
		board_name="rpi-3-cm"
		;;
	*)
		board_name="unknown"
		;;
	esac

	[ -e "/tmp/sysinfo" ] || mkdir -p "/tmp/sysinfo"

	echo "$board_name" > /tmp/sysinfo/board_name
	echo "$model" > /tmp/sysinfo/model
}

brcm2708_board_name() {
	local name

	[ -f /tmp/sysinfo/board_name ] && name=$(cat /tmp/sysinfo/board_name)
	[ -n "$name" ] || name="unknown"

	echo $name
}
