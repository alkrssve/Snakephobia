extends KinematicBody2D

var body_part = preload("res://Scenes/SnakePart.tscn")
onready var head = $SnakeHead
var direction = Vector2(0,1)
var segments = []

var down = false
var up = false
var left = false
var right = false

var colliding = false


func _ready():
	
	Global.player = self
	
	segments.append(head)
	Global.segments.append(head)
	
	for i in 3:
		var new_part = body_part.instance()
		segments.append(new_part)
		add_child(new_part)
		Global.segments.append(new_part)
		
	$BoostTimer.set_paused(true)

func _physics_process(delta):
	
	if Input.is_action_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
		
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
		
	if Input.is_action_pressed("ui_down"):
		$MoveTimer.set_paused(false)
		direction = Vector2(0,1)
		segments[0].rotation_degrees = 90
		down = true
	elif Input.is_action_just_released("ui_down"):
		down = false
	if Input.is_action_pressed("ui_up"):
		$MoveTimer.set_paused(false)
		direction = Vector2(0,-1)
		segments[0].rotation_degrees = 270
		up = true
	elif Input.is_action_just_released("ui_up"):
		up = false
	if Input.is_action_pressed("ui_left"):
		$MoveTimer.set_paused(false)
		direction = Vector2(-1,0)
		segments[0].rotation_degrees = 180
		left = true
	elif Input.is_action_just_released("ui_left"):
		left = false
	if Input.is_action_pressed("ui_right"):
		$MoveTimer.set_paused(false)
		direction = Vector2(1,0)
		segments[0].rotation_degrees = 0
		right = true
	elif Input.is_action_just_released("ui_right"):
		right = false
	
	if !down and !up and !left and !right:
		$MoveTimer.set_paused(true)
		
	if Input.is_action_just_pressed("boost") and $BoostTimer.is_paused() and segments.size() > 1:
		segments[segments.size()-1].queue_free()
		segments.pop_back()
		$SnakeHead/Camera2D.zoom.x -= 0.05
		$SnakeHead/Camera2D.zoom.y -= 0.05
		$MoveTimer.wait_time = 0.05 - (Global.speed/10)
		$BoostTimer.set_paused(false)
	
	if segments[0].get_node("WallDetection").is_colliding():
		colliding = true
	else:
		colliding = false
	
func update_position():
	for x in range(segments.size()-1,-1,-1):
		if colliding:
			pass
		elif x == 0:
			segments[x].global_position += direction * 16
		else:
			segments[x].global_position = segments[x-1].global_position
			segments[x].rotation_degrees = segments[x-1].rotation_degrees
			
		if x == segments.size()-1 and segments.size() > 1:
			segments[x].get_node("Sprite").region_rect = Rect2(0,0,22,16)
		elif x != segments.size()-1 and x != 0:
			segments[x].get_node("Sprite").region_rect = Rect2(22,0,22,16)
		
			

func _on_Timer_timeout():
	update_position()

func _on_BoostTimer_timeout():
	$MoveTimer.wait_time = Global.speed
	$BoostTimer.set_paused(true)
	
func _on_pickup_collected(pickup_type):
	Global.collect_money(pickup_type)
	if pickup_type == 0:
		var new_part = body_part.instance()
		segments.append(new_part)
		Global.segments.append(new_part)
		add_child(new_part)
		$SnakeHead/Camera2D.zoom.x += 0.05
		$SnakeHead/Camera2D.zoom.y += 0.05
		

func _on_shopItem_collected(shop_type):
	Global.items_purchased += 1
	Global.collect_item(shop_type)
	if (shop_type == 0):
		pass
	if (shop_type == 1):
		$MoveTimer.wait_time -= 0.01
	if (shop_type == 2):
		pass
		
	


