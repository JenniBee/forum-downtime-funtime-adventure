extends Sprite

var count = 0

func _ready():
	pass

func _on_Timer_timeout():
	count += 1
	get_tree().quit()
