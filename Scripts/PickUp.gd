extends Area2D

export var pickupType = 0
signal pickup_collected

func _ready():

	if(pickupType == 0):
		$AnimatedSprite.animation = "fruit"
	if(pickupType == 1):
		$AnimatedSprite.animation = "gold"
	

func _on_PickUp_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("pickup_collected", pickupType)
		randomize()
		position.x = rand_range(0,2500)
		position.y = rand_range(0,1000)
	else:
		randomize()
		position.x = rand_range(0,2500)
		position.y = rand_range(0,1000)
