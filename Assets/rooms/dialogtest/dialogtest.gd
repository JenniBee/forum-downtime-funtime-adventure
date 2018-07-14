
extends Node2D
var database

func _enter_tree():
	database = get_node("/root/database")
	var array = [1,1,1]
	array.resize(5)
	print(array[4])
	new_game()

func new_game():
	var newgame = Node.new()
	newgame.set_script(load("res://locales/dialogs/en_EN.gd"))
	add_child(newgame)
	newgame.newgame()
	_on_Button1_pressed()


func _on_Button1_pressed():
	if database.dialog_node == null:#there's no dialog node going on
		var dialog_node = load("res://dialogue/dialogue_base.tscn").instance()
		database.dialog_node = dialog_node
		dialog_node.npc = "frontiersman_steeltrap"
		add_child(dialog_node)

	pass # replace with function body 