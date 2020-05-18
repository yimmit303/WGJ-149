extends Area2D
var player_ref;
var disable_kill = false;

func _ready():
	player_ref = get_node("../../Player");
	connect("body_entered", player_ref, "on_anvil_hit");

func _process(delta):
	if disable_kill:
		disconnect("body_entered", player_ref, "on_anvil_hit");
