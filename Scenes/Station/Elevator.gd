extends "res://Scenes/Interactables/Interactable.gd"


# TODO: Make this move the player

var open = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _on_OpenArea_body_entered(body):
	if body.name == "Player" and open == false:
		open = true
		$ElevatorSprite.animation = "Open"

func _on_OpenArea_body_exited(body):
	if body.name == "Player" and open == true:
		open = false
		$ElevatorSprite.animation = "Close"


