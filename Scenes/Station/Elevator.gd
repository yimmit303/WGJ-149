extends Node2D


# TODO: Make this move the player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_OpenArea_body_entered(body):
	if body.name == "Player":
		$ElevatorSprite.animation = "Open"

func _on_OpenArea_body_exited(body):
	if body.name == "Player":
		$ElevatorSprite.animation = "Close"

