extends KinematicBody2D
var activated = false;
var gravity = Vector2(0, 9.81);
var velocity = Vector2();

func _physics_process(delta):
	if activated:
		velocity += gravity * 1.6;
		velocity = move_and_slide(velocity, Vector2.UP);
		if is_on_floor():
			# disables the anvil if it touches floor.
			var trigger = get_node("InteractionArea");
			trigger.disable_kill = true;

func activate():
	activated = true;
