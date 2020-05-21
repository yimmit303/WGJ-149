extends "res://Scenes/Interactables/Interactable.gd"

func _ready():
	type = "Coffee"
	details = []
	if randf() > 0.5:
		text_format = "Get coffee from the break room"
		player.inventory.append("Coffee")
	else:
		text_format = "Get yourself some coffee"

func interact(event):
	if goal:
		if event is InputEventKey and event.pressed == true and event.echo == false and event.scancode == KEY_E:
			emit_signal("player_interacted", self, type, details)

func get_formatted_text():
	return text_format
