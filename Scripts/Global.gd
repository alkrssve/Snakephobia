extends Node

var coins = 1000
var length = 3
var bullet_power = 1
var speed = 0.2
var segments = []
var number_shielded = 0
var items_purchased = 0
var shop_items = []
var added_price = 0

var hud
var player

func collect_money(pickupType):
	if (pickupType == 0):
		length += 1
	if (pickupType == 1):
		coins += 1
	hud.load_coins()
	
func collect_item(shopType):
	if (shopType == 0):
		coins -= 35 + added_price
		bullet_power += 1
	if (shopType == 1):
		speed -= 0.01
		coins -= added_price + added_price
	if (shopType == 2):
		number_shielded += 1
		coins -= 30 + added_price
	added_price += 5
	for x in range(segments.size()-1):
		shop_items[x].update_price()
	hud.load_coins()
