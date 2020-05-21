extends "res://Scenes/Interactables/Interactable.gd"

export(int, 1, 5) var floor_num = 1

func _ready():
	type = "Cabinet"
	details = [str(floor_num)]
	text_format = "Get files from floor " + str(floor_num)

func interact(event):
	if goal:
		if event is InputEventKey and event.pressed == true and event.echo == false and event.scancode == KEY_E:
			emit_signal("player_interacted", self, type, details)
			player.inventory.append("Files")
