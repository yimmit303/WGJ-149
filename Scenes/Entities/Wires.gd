extends Area2D

var player_ref;


func _ready():
	player_ref = get_tree().get_root().get_child(0).get_player()
	connect("body_entered", player_ref, "on_wire_trip");
