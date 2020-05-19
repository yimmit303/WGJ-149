extends VBoxContainer

func _ready():
	load_level_objectives()
	
func animate_obj(label):
	while label.text[0] == " ":
		label.text[0] = ""
		OS.delay_msec(10)

func load_level_objectives():
	var child_list = get_children()
	for i in range(2, get_child_count()):
		child_list[i].text = "                                    " + child_list[i].text


func _on_Level_camera_finsished():
#	var child_list = get_children()
#	for i in range(2, get_child_count()):
#		var thread = Thread.new()
#		thread.start(self, "animate_obj", child_list[i])
#		OS.delay_msec(100)
	pass

func _player_interacted(object_name, object_details):
	pass
