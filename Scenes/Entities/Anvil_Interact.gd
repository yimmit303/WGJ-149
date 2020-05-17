extends Area2D
var player_ref;


func _ready():
	player_ref = get_node("../../Player");
	connect("body_entered", player_ref, "on_anvil_hit");
