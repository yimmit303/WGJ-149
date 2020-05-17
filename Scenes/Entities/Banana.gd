extends Area2D

var player_ref;
func _ready():
	player_ref = get_node("../Player");


func _on_Banana_body_entered(body):
	if body.get_name() == "Player":
		player_ref.on_banana_slip();
