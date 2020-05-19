extends "res://Scenes/Interactables/Interactable.gd"


# TODO: Make this move the player

var open = false
var moving = false
var floor_num

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func interact(event):
	if !moving:
		if event is InputEventKey and event.pressed == true and event.echo == false:
			if event.scancode == KEY_W and floor_num < 5:
				moving = true
				
				player.gravity = Vector2(0, 0)
				player.velocity = Vector2(0, 0)
				player.animator.animation = "Idle"
				player.can_move = false
				
				$Tween.interpolate_property(player, "modulate", Color(1,1,1,1), Color(1,1,1,0), 0.5, Tween.TRANS_LINEAR)
				$Tween.start()
				yield($Tween, "tween_completed")
				
				open = false
				$ElevatorSprite.animation = "Close"
	
				
				$Tween.interpolate_property(	player, "position", player.position, player.position + Vector2(0, -80),
												1, Tween.TRANS_LINEAR)
				$Tween.start()
				yield($Tween, "tween_completed")
				
				$Tween.interpolate_property(player, "modulate", Color(1,1,1,0), Color(1,1,1,1), 0.5, Tween.TRANS_LINEAR)
				$Tween.start()
				yield($Tween, "tween_completed")
				player.gravity = Vector2(0, 9.81)
				player.can_move = true
				
				moving = false
				
			
			if event.scancode == KEY_S and floor_num > 1:
				moving = true
				
				player.gravity = Vector2(0, 0)
				player.velocity = Vector2(0, 0)
				player.animator.animation = "Idle"
				player.can_move = false
				
				$Tween.interpolate_property(player, "modulate", Color(1,1,1,1), Color(1,1,1,0), 0.5, Tween.TRANS_LINEAR)
				$Tween.start()
				yield($Tween, "tween_completed")
				
				open = false
				$ElevatorSprite.animation = "Close"
	
				
				$Tween.interpolate_property(	player, "position", player.position, player.position + Vector2(0, 80),
												1, Tween.TRANS_LINEAR)
				$Tween.start()
				yield($Tween, "tween_completed")
				
				$Tween.interpolate_property(player, "modulate", Color(1,1,1,0), Color(1,1,1,1), 0.5, Tween.TRANS_LINEAR)
				$Tween.start()
				yield($Tween, "tween_completed")
				player.gravity = Vector2(0, 9.81)
				player.can_move = true
				
				moving = false

func _on_OpenArea_body_entered(body):
	if body.name == "Player" and open == false:
		open = true
		$ElevatorSprite.animation = "Open"

func _on_OpenArea_body_exited(body):
	if body.name == "Player" and open == true:
		open = false
		$ElevatorSprite.animation = "Close"


