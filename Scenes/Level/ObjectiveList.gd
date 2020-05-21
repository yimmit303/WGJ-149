extends VBoxContainer

var obj_list = [1,1,1]

var obj1Label
var obj2Label
var obj3Label

var interactables_list

var previous_floor_num = -1

func _ready():
	obj1Label = get_node("Objective1")
	obj2Label = get_node("Objective2")
	obj3Label = get_node("Objective3")
	obj1Label.visible = false
	obj2Label.visible = false
	obj3Label.visible = false
	
	interactables_list = get_tree().get_root().get_child(0).get_level_interactables()
	obj_list[0] = generate_objective()
	obj1Label.visible = true
	obj1Label.text = obj_list[0][2]
	obj_list[1] = generate_objective()
	obj2Label.visible = true
	obj2Label.text = obj_list[1][2]
	obj_list[2] = generate_objective()
	obj3Label.visible = true
	obj3Label.text = obj_list[2][2]

func generate_objective():
	randomize()
	var floor_nums = [0, 1, 2, 3, 4]
	floor_nums.erase(previous_floor_num)
	floor_nums.shuffle()
	var selected_floor = floor_nums[0]
	previous_floor_num = selected_floor
	var selected_floor_node = interactables_list[selected_floor]
	var interactable
	if selected_floor_node.get_child_count() == 1:
		interactable = selected_floor_node.get_child(0)
	else:
		interactable = selected_floor_node.get_child(randi() % selected_floor_node.get_child_count())
	interactable.make_goal()
	return format_objective(interactable)

func format_objective(interactable):
	var text = interactable.get_formatted_text()
	return [interactable.type, interactable.details, text]

func on_player_interacted(interactable, object_type, object_details):
	var label_list = [obj1Label, obj2Label, obj3Label]
	for i in range(len(obj_list)):
		var objective = obj_list[i]
		if objective != null:
			if objective[0] == object_type and objective[1] == object_details:
				interactable.complete()
				obj_list[i] = generate_objective()
				label_list[i].visible = true
				label_list[i].text = obj_list[i][2]
