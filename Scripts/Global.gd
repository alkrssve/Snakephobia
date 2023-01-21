extends Node

var coins = 0
var length = 3

var hud
var player

func collect_money(pickupType):
	if (pickupType == 0):
		length += 1
	if (pickupType == 1):
		coins += 1
	hud.load_coins()
