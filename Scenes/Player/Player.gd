extends KinematicBody2D
var gravity = Vector2(0, 9.81);
var velocity = Vector2();
var sprint_max = 650.0;
var walk_max = 250.0;
var cur_max = walk_max;
var friction = 0.17;
var move_force = 75;

func _physics_process(delta):
	velocity += gravity * 1.6;
	var dir_vec = process_input();
	velocity += dir_vec;
	velocity = move_and_slide(velocity, Vector2.UP);


func process_input():
	var tmp_vel = velocity;
	var ret_vec = Vector2();
	var moved = false;
	if Input.is_action_pressed("sprint"):
		cur_max = sprint_max;
	else:
		cur_max = walk_max;
	if Input.is_action_pressed("move_right"):
		tmp_vel.x += move_force;
		if tmp_vel.length_squared() < pow(cur_max, 2):
			velocity.x += move_force;
			moved = true;
	if Input.is_action_pressed("move_left"):
		tmp_vel.x -= move_force;
		if tmp_vel.length_squared() < pow(cur_max, 2):
			velocity.x -= move_force;
			moved = true;
	if not moved and is_on_floor():
		# floor friction, only applies when not accelerating
		velocity.x *= 1.0 - friction;
	elif not moved and not is_on_floor():
		# air friction, only applies when not accelerating
		velocity.x *= 1.0 - (friction * 0.1);
	if not moved and velocity.length_squared() <= 30:
		# Stops the velocity if it gets below min-threshold and not moving
		velocity.x = 0;
	return ret_vec;
	
func on_banana_slip():
	print("I have slipped on a banana.");
