extends Area2D

export var shopType = 0
signal shopItem_collected

func _ready():
	if(shopType == 0):
		$AnimatedSprite.animation = "Bullets"
	if(shopType == 1):
		$AnimatedSprite.animation = "Potion"
	if(shopType == 2):
		$AnimatedSprite.animation = "Shield"


func _on_ShopItem_body_entered(body):
	if body.is_in_group("Player"):
		$E.visible = true


func _on_ShopItem_body_exited(body):
	if body.is_in_group("Player"):
		$E.visible = false
