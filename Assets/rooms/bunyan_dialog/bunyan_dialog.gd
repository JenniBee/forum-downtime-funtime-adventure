
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
	_on_Button2_pressed()


func _on_Button2_pressed():
	var dialog_node = load("res://dialogue/dialogue_bunyan.tscn").instance()
	database.dialog_node = dialog_node
	dialog_node.npc = "pb_in_chair"
	add_child(dialog_node)

	pass # replace with function body 