extends Sprite

var count = 0

func _ready():
	pass

func _on_Timer_timeout():
	count += 1
	get_node("DFAF").queue_free() 
	
func _on_Timer2_timeout():
	get_node("Godot").queue_free() 

func _on_Timer3_timeout():
	get_tree().change_scene("res://scenes/Escoria/MainSceneFin.scn") 