extends Area2D

var root;
func _ready():
	root = get_node("..");



func _on_TriggerArea_body_entered(body):
	if body.get_name() == "Player":
		if root != null:
			root.activate();
		elif root == null:
			print("anvil trigger broke");
