extends Area2D

export var shopType = 0
signal shopItem_collected
var in_range = false
var price = 0

func _ready():
	Global.shop_items.append(self)
	if(shopType == 0):
		$AnimatedSprite.animation = "Bullets"
		$Price.text = String(35)
		price = 35
	if(shopType == 1):
		$AnimatedSprite.animation = "Potion"
		$Price.text = String(25)
		price = 25
	if(shopType == 2):
		$AnimatedSprite.animation = "Shield"
		$Price.text = String(30)
		price = 30

func _physics_process(delta):
	if Input.is_action_just_pressed("interact") and in_range and Global.coins > price:
			emit_signal("shopItem_collected", shopType)
			
func _on_ShopItem_body_entered(body):
	if body.is_in_group("Player"):
		$E.visible = true
		$Price.visible = true
		$DollarSign.visible = true
		in_range = true
			


func _on_ShopItem_body_exited(body):
	if body.is_in_group("Player"):
		$E.visible = false
		$Price.visible = false
		$DollarSign.visible = false
		in_range = false

func update_price():
	price += 5
	$Price.text = String(price)

