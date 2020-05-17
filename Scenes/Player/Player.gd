extends KinematicBody2D
var gravity = Vector2(0, 9.81);
var velocity = Vector2();
var max_speed = 600.0;
var friction = 0.09;
var move_force = 1000;
var jump_force = 20000;


func _physics_process(delta):
	velocity += gravity * delta * 100;
	var dir_vec = process_input(delta);
	velocity += dir_vec;
	velocity = move_and_slide(velocity, Vector2.UP);


func process_input(delta):
	var tmp_vel = velocity;
	var ret_vec = Vector2();
	var moved = false;
	if Input.is_action_pressed("move_right"):
		tmp_vel.x += move_force * delta;
		if tmp_vel.length_squared() < pow(max_speed, 2):
			velocity.x += move_force * delta;
			moved = true;
	if Input.is_action_pressed("move_left"):
		tmp_vel.x -= move_force * delta;
		if tmp_vel.length_squared() < pow(max_speed, 2):
			velocity.x -= move_force * delta;
			moved = true;
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y -= jump_force * delta;
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
