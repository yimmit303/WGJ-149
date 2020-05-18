extends Node2D

func _ready():
	pass 

func _on_OpenArea_body_entered(body):
	if body.name == "Player":
		$DoorSprite.animation = "Open"

func _on_OpenArea_body_exited(body):
	if body.name == "Player":
		$DoorSprite.animation = "Close"
