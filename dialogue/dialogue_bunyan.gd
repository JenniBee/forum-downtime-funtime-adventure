
extends Node2D


####nodes shortcuts
var db #database: ie: db.dialogue is shortcut to "dialogue" array in /root/database/
var scene_runner = null

#dialogue buttons area
var picker#the main scroll container
var sorter#a dummy "sorter" node (used a sort of "folder" to contain/isolate all the buttons)


var textfield_player
var textfield_npc


var npc = null
var sorter_fillup

var speech = null
#speech [null] #no speaking process ongoing
#speech hero #process hero speaking
#speech npc #process npc speaking
#speech done #speaking process is done (usually for "press any key to continue" stuff)

#indexing variables
var index = [0]#stores all the dialog lines who belong to the requested npc

#basic services
var mouse_button = false
var accept_key = false
var wait_for_input = false
var only_once_key = true


func _enter_tree():#index the database
	db = get_node("/root/database")
	picker = get_node("choice_picker")
	sorter = get_node("choice_picker/sorter")
	textfield_player = get_node("hero_speech")
	textfield_npc = get_node("bunyan_speech")
	set_process_input(true)
	set_process(true)
	index()


#load and hybernate scene runner
	scene_runner = Node.new()
	scene_runner.set_script(load("res://dialogue/scene_runner.gd"))
	scene_runner.db = db#db node
	scene_runner.base = get_node(".")#who's your daddy? I am your daddy! (we tell to our child where it can find us)
	scene_runner.textfield_player = textfield_player#where do the hero speak
	scene_runner.textfield_npc = textfield_npc#where do the npc speak
	add_child(scene_runner)#deliver!

#	scene_runner.id = id#absolute value of dialogue line




func scene_done():#there was a scene... which is now finished: cleanup and check what other dialogue options the player have
	index()
	get_choices()

#func _input(event):
#	if (event.type == InputEvent.MOUSE_BUTTON):
#		mouse_button = true
#	else:
#		mouse_button = false

func _process(delta):
	accept_key = Input.is_action_pressed("ui_accept")
	mouse_button = Input.is_mouse_button_pressed(1)
	if speech == "hero":
		speech_hero()
	elif speech == "npc":
		speech_npc()
	elif speech == "done":
		pass


##botton of _process(delta)
	only_once_key = !accept_key


func speech_hero():
	pass


func speech_npc():
	pass

func update_for(node):
	var theme = node.get_theme()
	if theme == null:
		theme = Theme.new()
	theme.set_default_font(database.current_font)
	node.set_theme(theme)

func update_textfield():
	update_for(textfield_player)
	update_for(textfield_npc)



func _ready():
	update_textfield()
	get_choices()

func run_action(id):


	scene_runner.awake(id)
	
#	if scene_runner != null:
#		scene_runner.die()
#	scene_runner = Node.new()
#	scene_runner.set_script(load("res://dialogue/scene_runner.gd"))
#	scene_runner.id = id#absolute value of dialogue line
#	add_child(scene_runner)#deliver!

	
	
	
#database operations
	if db.dialogue[id].has("enabled"):
		db.dialogue[id]["enabled"] = false#when a line is picked, it get disabled

	if db.dialogue[id].has("disable"):
		var line_to_activate = db.dialogue[id]["disable"]
		if typeof(line_to_activate) == 21:
			for i in range(line_to_activate.size()):
				var sub_line = line_to_activate[i]
				for i in range(index.size()):
					if db.dialogue[index[i]]["id"] == sub_line:
						db.dialogue[index[i]]["enabled"] = false
		else:
			for i in range(index.size()):
				if db.dialogue[index[i]]["id"] == line_to_activate:
					db.dialogue[index[i]]["enabled"] = false




	if db.dialogue[id].has("activate"):
		var line_to_activate = db.dialogue[id]["activate"]
		if typeof(line_to_activate) == 21:
			for i in range(line_to_activate.size()):
				var sub_line = line_to_activate[i]
				for i in range(index.size()):
					if db.dialogue[index[i]]["id"] == sub_line:
						db.dialogue[index[i]]["enabled"] = true
		else:
			for i in range(index.size()):
				if db.dialogue[index[i]]["id"] == line_to_activate:
					db.dialogue[index[i]]["enabled"] = true
#					print("current check is: " +str(db.dialogue[index[i]]))


func get_choices():
	var choices_found = []
	for i in range(index.size()):#browse the [index] who contain only npc lines
		
		var line_is_okey = false
		var line_to_check = db.dialogue[index[i]]
		if line_to_check.has("enabled"):
			if line_to_check["enabled"]:
				line_is_okey = true

#				this is only for module
				line_is_okey = mod_line_check(line_to_check)
#				delete/disable if module are not used

		if line_is_okey:#add line
			var size = choices_found.size()
			choices_found.resize(size+1)
			choices_found[size] = index[i]
			
	if choices_found.size() < 1:
		no_choices_aviable()
	else:
		place_buttons(choices_found)

func place_buttons(buttons):
	sorter_cleanup()
	for i in range(buttons.size()):
		deliver_button(buttons[i])


func no_choices_aviable():
	pass



func mod_line_check(line_to_check):#if the line_to_check reach the end of this module; mean all the requiment are meet

#complete rewrite needed! events are separate in database!


##############################################
#		module "inclusive": just need a single valid event (set true), if so.. you shall pass
##############################################
	if line_to_check.has("inclusive"):
		var all_is_fine = false#ok, let's see if at least one save us! (if all are false... the line is doomed)
		var inclusive_check = line_to_check["inclusive"]
		if typeof(inclusive_check) == 21:#it an array of multiple events... multiple check
			for i in range(inclusive_check.size()):
				if db.events.has(inclusive_check[i]):
					if db.events[inclusive_check[i]]:#we've found it.. line is saved!
						all_is_fine = true#
#					else: just keep checking the other events; "all_is_fine" stay false
#						      which mean soon this line will doomed if something doesn't change
				else:
					print("ERROR: event \"" + str(inclusive_check[i]) + "\" mistyped or inexistent")

		elif typeof(inclusive_check) == 1:#this line check (for a single boolean) behave similary to the "exclusive" module: one wrong, you're out
			if db.events.has(inclusive_check):
				if db.events[inclusive_check]:#we've found it.. line is saved!
					all_is_fine = true#
			else:
				print("ERROR: event \"" + str(inclusive_check) + "\" mistyped or inexistent")

#				return false#you had only one single requiment, son, and you failed: you're out :[
		if !all_is_fine:#nothing saved you; no point in further checks: you're gone
			return false
#		else: [all_is_fine... for now: but another module will check you]

##############################################/end "inclusive module"


#next [module check] will take place only nothing went wrong with the previous one

##############################################
#		module "exclusive": "exclusive" events are a *strick requiment*: if one or any of these event is false... the line is doomed
##############################################

	if line_to_check.has("exclusive"):
		var exclusive_check = line_to_check["exclusive"]
		if typeof(exclusive_check) == 21:#it an array of multiple events; one wrong
			for i in range(exclusive_check.size()):
				if db.events.has(exclusive_check[i]):#okey, event name is not mistaken
					if !db.events[exclusive_check[i]]:#exclusive event is set [false]! abort! abort!
						return false
				else:#event doesn't even exist or is mis-typed: abort! abort!
					return false
		elif typeof(exclusive_check) == 1:#this line check (for a single boolean) behave similary to the "exclusive" module: one wrong, you're out
			if db.events.has(exclusive_check):#okey, event name is not mistaken
				if !db.events[exclusive_check]:#exclusive event is set [false]! abort! abort!
					return false
			else:#exclusive event doesn't even exist or is mis-typed: abort! abort!
				return false
##############################################/end "inclusive module"
	return true#you reached the end of the tunnel.. you won!



func deliver_button(id):#this is the function who "send the pick button" in the button array
#now REMEMBER: the "id" value is the ABSOLUTE position in the database.dialogue array
#to get the RELATIVE value you need the database.dialogue[id]["id"]
	var button = load("res://dialogue/button.tscn").instance()
#	button.set_name(str(order))
	if sorter_fillup == null:#sorter_fillup is [null] only when there are no other button previously: basically this is the first button and don't need special treatment
		sorter_fillup = [button]
	else:#button that come AFTER the first one need to be put into its place in the roster (2nd..3rd... etc), placed at the bottom of the list
		var sorter_size = sorter_fillup.size()
		sorter_fillup.resize(sorter_size+1)
		sorter_fillup[sorter_size] = button

	var order_in_sorter = sorter_fillup.size()#button order number into the sorter
	button.id = id
	button.order = order_in_sorter#let button knows its placment order (used so button node can find its previous button)
	button.database = database
	var text = db.dialogue[id]["q"]#button text will be its question speech
	if typeof(text) == 21:#... but if is an array of speech, only the first one will shown
		text = text[0]
	
#	button.text = db.dialogue[id]["q"]#button text goes here


	if (text == "room pb_in_chair"):
		get_node("/root/constants").setScene("res://Assets/rooms/pb_in_chair/pb_in_chair.tscn") 
	elif (text == "room steeltrap"):
		get_node("/root/constants").setScene("res://Assets/rooms/steeltrap/steeltrap.tscn")
	elif (text == "room tempending2"):
		get_node("/root/constants").setScene("res://Assets/rooms/ending2/ending2.tscn")
	elif (text == "room bunyanfinal"):
		get_node("/root/constants").setScene("res://Assets/rooms/bunyan_dialog/bunyan_final.tscn")

	else:
		button.text = text#button text goes here
		button.base = get_node(".")#when button need to access to dialogue main node (sorter_fillup array etc)
		button.picker = picker#the scroll container node
		button.sorter = sorter#sorter node (all, and ONLY, buttons will contained here)
		button.set_name("choice "+ str(order_in_sorter))
	
		sorter.add_child(button)

func sorter_cleanup():
	sorter_fillup = null
	for i in range(sorter.get_child_count()):
		sorter.get_child(i).death_signal = true

#func index():#find and index all the lines who belong to the current npc
#	var index_cursor = 1#used to indexing
#	for i in range(db.dialogue.size()):#browse the whole dialogue db
#		var linecheck = db.dialogue[i]
#		if linecheck.has("npc"):
#			if linecheck["npc"] == npc:#check if this line belong to the current npc
#				index.resize(index_cursor)#    the first is zero;
#				index[index_cursor-1] = i#    but the its size is one:
#				index_cursor+=1#        so we need disposable variable to suit our needs
##				print("index is : " + str(index.size()))
#		else:
#			print("the line in database:\ndialogue["+str(i)+"]\nis missing to who belong")

func index():#find and index all the lines who belong to the current npc
	index = []
	for i in range(db.dialogue.size()):#browse the whole dialogue db
#		print("i is : " + str(i))
		var linecheck = db.dialogue[i]
		if linecheck.has("npc"):
			if linecheck["npc"] == npc:#check if this line belong to the current npc
				var size= index.size()
				index.resize(size+1)#    the first is zero;
				index[size] = i#    but the its size is one:
		else:
			print("the line in database:\ndialogue["+str(i)+"]\nis missing to who belong")

func update_language(lang, font):
	