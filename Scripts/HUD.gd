extends CanvasLayer



func _ready():
	load_coins()
	
	Global.hud = self
	
func load_coins():
	$Money.text = String(Global.coins)
