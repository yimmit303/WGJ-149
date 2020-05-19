extends "res://Scenes/Interactables/Interactable.gd"


# TODO: Make this move the player

var open = false
var floor_num

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func interact(event):
	if event is InputEventKey and event.pressed == true and event.echo == false:
		print("We are on floor: ", floor_num)
		if event.scancode == KEY_W and floor_num < 5:
			print("Going Up!")
		if event.scancode == KEY_S and floor_num > 1:
			print("Going Down!")

func _on_OpenArea_body_entered(body):
	if body.name == "Player" and open == false:
		open = true
		$ElevatorSprite.animation = "Open"

func _on_OpenArea_body_exited(body):
	if body.name == "Player" and open == true:
		open = false
		$ElevatorSprite.animation = "Close"


