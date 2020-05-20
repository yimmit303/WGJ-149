extends "res://Scenes/Interactables/Interactable.gd"

func _ready():
	type = "Coffee"
	details = []

func interact(event):
	if event is InputEventKey and event.pressed == true and event.echo == false and event.scancode == KEY_E:
		emit_signal("player_interacted", type, details)
