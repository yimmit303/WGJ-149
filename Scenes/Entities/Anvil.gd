extends KinematicBody2D
var activated = false;
var gravity = Vector2(0, 9.81);
var velocity = Vector2();

func _physics_process(delta):
	if activated:
		velocity += gravity * 1.6;
		velocity = move_and_slide(velocity, Vector2.UP);

func activate():
	activated = true;
