extends Node







var db
var id#absolute id for the dialgue line database.dialogue[id]
var base
var textfield_player
var textfield_npc

var status = -1
#status values:
#-1 hybernated: no scene ongoing, we're waiting for the next job
#0 - enter in the scene
#1 - hero is speaking
#2 - npc is speaking
#3 - finished speaking, waiting for a key to activate next step
#4 nothing else to do, activate hybernation

var storyboard = []#a scene is made by multiple actions-speech, this array will contain them all
var storyboard_row = 0#keep tracks of which action-speech we're currently at

#scene script


#typewriter settings
var typewriting = false
var tw_cursor = 0
var wait_for_key = false
var wait_for_key_clear = false
const tw_speed = 10#typewriter speed will change (goes faster when player press action key)
const tw_spd_multi = 10#typewriter speed multiplier when action key or mouse is pressed

func insert_storyboard(text, orator):
	var position = storyboard.size()
	storyboard.resize(position+1)
	storyboard[position] = {"text":text}
	if orator == null:
		storyboard[position]["orator"] = "player"
	else:
		storyboard[position]["orator"] = orator

#	storyboard[position] = {"text":text}
#	if orator == null:
#		storyboard[position]["orator"] = "player"
#	else:
#		storyboard[position]["orator"] = orator

func _enter_tree():
	pass



func hybernate():#the scene is finished or didn't start one yet.
	storyboard = []
	storyboard_row = 0
	typewriting = false
	status = -1
	textfield_player.set_text("")
	textfield_npc.set_text("")
	textfield_npc.set_visible_characters(0)
	textfield_player.set_visible_characters(0)

	set_process(false)

func awake(action_id):#there's a request for a scene


#rendundant cleanup
##
	textfield_npc.set_visible_characters(0)
	textfield_player.set_visible_characters(0)
#####

	set_process(true)
	status = 0
	id = action_id
	var line = db.dialogue[id]

#	textfield_player.set_text(str(db.dialogue[id]["q"]))
#	textfield_npc.set_text(str(db.dialogue[id]["a"]))

	set_process(true)
	###storyboard builder



	#player speech: the first one to speak


	if typeof(line["q"]) == 21:#if the question is an array, only the last one will be shown
		var size = line["q"].size() -1
		insert_storyboard(line["q"][size], null)
	else:
		insert_storyboard(line["q"], null)
	
	#npc speech
	if line.has("a"):#npc direct answer is not mandatory as cinematic or no-reply may be used
		if typeof(line["a"]) == 21:
			for i in range(line["a"].size()):
				insert_storyboard(line["a"][i], line["npc"])
		else:
			insert_storyboard(line["a"], line["npc"])


	#cinematic: some dialogues may "ignite" complete cut-scene where the player speaks again or another guest npc may come
	if line.has("cinematic"):
		for i in range(line["cinematic"].size()):
			var cine = line["cinematic"][i]
			print(str(line["cinematic"][i]))
			insert_storyboard(cine["text"], cine["speaker"])
	director_room()


func _ready():
	pass


func next_step():
	storyboard_row += 1
	print("size: " + str(storyboard.size()))
	print("row: " + str(storyboard_row))
	if storyboard_row >= storyboard.size():#when we (scene runner) reach the end of the storyboard we: 1. tell to our parents we're done 2: we die
		print("we have finished")
		hybernate()#self explicatory
		base.scene_done()
		return
	
	director_room()
	


func director_room():
	print("new line")
	var read_script = storyboard[storyboard_row]
	print("status is : " +str(status))
	if status == 0:
		print("let's go to typewriting")
		typewriting = true
		tw_cursor = 0
		if read_script["orator"] == "player":
			textfield_player.set_text(read_script["text"])
			textfield_player.set_visible_characters(0)
			status = 1
		else:
			textfield_npc.set_text(read_script["text"])
			textfield_npc.set_visible_characters(0)
			status = 2



func _process(delta):
	if typewriting:
		typewriter(delta)

	if wait_for_key:
		var key = false
		if base.accept_key or base.mouse_button:
			key = true
		
		if key and wait_for_key_clear:
			wait_for_key = false
			status = 0
			next_step()
		wait_for_key_clear = !key

func typewriter(delta):#typewriter machine (let the message appear one letter after another)
	var speed = tw_speed
	if base.accept_key or base.mouse_button:
		speed *= tw_spd_multi
	tw_cursor += speed*delta
	var size = 7
	if status == 1:
		textfield_player.set_visible_characters(tw_cursor)
		size = textfield_player.get_total_character_count()
	elif status == 2:
		textfield_npc.set_visible_characters(tw_cursor)
		size = textfield_npc.get_total_character_count()
	if tw_cursor >= size:
		status = 3
		typewriting = false
		wait_for_key = true
		wait_for_key_clear = false
		print("waiting for key")