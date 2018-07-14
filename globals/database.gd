extends Node


var dialogue = null#this will contain all the dialog lines
var events = null


#nodes not active are set "null"
var dialog_node = null

#future nodes
#var inventory = null
#var player = null
#var room = null



const language_base = "en_EN"
const aviable_language = ["en_EN"]

var current_language = null
var current_font = null

func translate(language):
	var custom_font_required = "none"#basically "everything is latin" until proven otherwise
	var language_not_found = true

	for i in range(aviable_language.size()):
		if typeof(language) == typeof(aviable_language[i]):
			
			if language == aviable_language[i]:
				language_not_found = false
				current_language = language

	if language_not_found:#request language was not found: abort translation
		print("translation failed; request language is not in the database")
		return
	translate_dialogues(language)


func translate_dialogues(language):
	current_font = null
	if typeof(language) == 21:#[language] is array: contain font requiments
		print("language is an array!")
		var check_font = Directory.new()
		if check_font.open("res://Assets/fonts/") == OK:
			if check_font.file_exists(str(language[1])):
				current_font = load("res://Assets/fonts/DejaVuSans/DejaVuSans.ttf")
			else:
				print("font DOESN't exist!!!!")
				
		language = language[0]
	var translation_node = Directory.new()
	if translation_node.open("res://locales/dialogs/") == OK:
		if !translation_node.file_exists(str(language)+".gd"):
			return
	translation_node = Node.new()
	translation_node.set_script(load("res://locales/dialogs/"+str(language)+".gd"))
	var translation = translation_node.dialogue
#	print(translation)
	for i in range(translation.size()):
		var translation_row = translation[i]
		if !translation_row.has("id") or !translation_row.has("npc"):
#			print("problem here")
			return
		#find the npc, find the id
#		print("original \n" +str(dialogue))
		for b in range(42):
			if dialogue[b].has("id") and dialogue[b].has("npc"):
				if (dialogue[b]["id"] == translation_row["id"]) and (dialogue[b]["npc"] == translation_row["npc"]):
#					print(str(dialogue[b]["id"])+ " and " + str(translation_row["id"]))
					dialogue[b]["q"] = translation_row["q"]
					if translation_row.has("a"):
						dialogue[b]["a"] = translation_row["a"]
					if translation_row.has("cinematic"):
						for c in range(translation_row["cinematic"].size()):
							dialogue[b]["cinematic"][c]["text"] = translation_row["cinematic"][c]["text"]


	if dialog_node != null:
		dialog_node.update_textfield()


func _ready():
	current_language = language_base
	dummy_stuff()
	pass


func dummy_stuff():#temporary function that set/unset stuff for testing purpose
	events = {"rain": true,"cloudy": false,"elections": false}

   
	