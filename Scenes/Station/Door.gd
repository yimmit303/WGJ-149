extends Node2D

var open = false

func _ready():
	pass 

func _on_OpenArea_body_entered(body):
	if body.name == "Player" and open == false:
		open = true
		$DoorSprite.animation = "Open"

func _on_OpenArea_body_exited(body):
	if body.name == "Player" and open == true:
		open = false
		$DoorSprite.animation = "Close"


func _on_OpenArea_area_entered(area):
	if area.name == "NPCArea" and open == false:
		open = true
		$DoorSprite.animation = "Open"


func _on_OpenArea_area_exited(area):
	if area.name == "NPCArea" and open == true:
		open = false
		$DoorSprite.animation = "Close"
