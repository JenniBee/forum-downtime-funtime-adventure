
extends Label

#nodes
var base
var picker #the text box node which will contain all the buttons and the scroller
var sorter
var database

var order
var text
var id



#module design_stuff
const mod_opacity_min = 0.3
const mod_opacity_max = 0.9
const mod_opacity_speed = 3


#signals

var status = 0#
############### status signals:
############### 0 button wait for order: status_standby()
############### 1 button is set to die: status_perform_death()
############### 2 button is selected!!: status_picked()
var death_signal = false
var mouse_over = false


func update_text():
	var theme = get_theme()
	if theme == null:
		theme = Theme.new()
	theme.set_default_font(database.current_font)
	set_theme(theme)


func _enter_tree():
	update_text()
	set_focus_mode(2)
	set_text(text)
	set_ignore_mouse(false)
	set_autowrap(true)
	

func _ready():
	var previous = null#previous will remain "null" for the first one... for obvious reasons
	if order > 1:
		previous = base.sorter_fillup[order-2]
		var mypathname = "../" + str(get_name())
		previous.set_focus_neighbour(3, mypathname)
		var pathname = "../" + str(previous.get_name())
		set_focus_neighbour(1, pathname)
	ui_fix(previous)



	set_process(true)



func mod_design(delta):#various fx effects that can be safetily disabled
	var opacity = get_opacity()
	
	if  has_focus():#make it brigh
		if opacity < mod_opacity_max:
			set_opacity(opacity+mod_opacity_speed*delta)
		else:
			return
	elif opacity > mod_opacity_min:
		release_focus()
		set_opacity(opacity-mod_opacity_speed*delta)

func status_perform_death(delta):

#################fx module######fade to black before die
	var opacity = get_opacity()#		
	set_opacity(opacity-1*delta)#		
	if opacity > 0:#					
		return#							
################################delete this to disable

	queue_free()


func status_standby(delta):#button is waiting for order // switchable

	mod_design(delta)

	if base.mouse_button:
		if mouse_over:
			for i in range(sorter.get_child_count()):
				sorter.get_child(i).status = 1
				
			status = 2

func status_picked(delta):#button is selected by player // rien ne va plus 

#################fx module######make it bright before it dies
	var opacity = get_opacity()#		
	set_opacity(opacity+1*delta)#		
	if opacity < 1.5:#					
		return#							
################################delete this to disable

	base.run_action(id)
	status = 1



func _process(delta):
	if status == 0:
		status_standby(delta)
	elif status == 1:
		status_perform_death(delta)
	elif status == 2:
		status_picked(delta)

func ui_fix(previous):
	var right_border = -20
	var up_border = 1
	var size = get_size()
	size.x = picker.get_size().x+right_border
	set_size(size)
	var rows = get_line_count()
	size.y *= rows
	set_size(size)


	if previous != null:
		var pos = get_pos()
		pos.y = previous.get_size().y -35 + previous.get_pos().y -35 +  up_border
		set_pos(pos)
	var new_y_size = get_pos().y + size.y
	sorter.set_custom_minimum_size(Vector2(0,new_y_size))


func _on_Button_mouse_enter():
	mouse_over = true
	grab_focus()

func _on_Button_mouse_exit():
	mouse_over = false




func _on_Button_focus_enter():
	var upper_border = -40
	if !mouse_over:
		picker.set_v_scroll( get_pos().y + upper_border )
	pass # replace with function body
