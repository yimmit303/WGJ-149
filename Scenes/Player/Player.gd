extends KinematicBody2D
var gravity = Vector2(0, 8.6);
var velocity = Vector2();
var max_speed = 2000.0;
var friction = 0.05;
var move_force = 2000;
var jump_force = 20000;

func _ready():
	pass


func _physics_process(delta):
	velocity += gravity;
	var dir_vec = process_input(delta);
	velocity += dir_vec;
	velocity = move_and_slide(velocity, Vector2.UP);
	velocity.x *= 1.0 - friction;

func process_input(delta):
	var ret_vec = Vector2();
	if velocity.length_squared() < pow(max_speed, 2):
		if Input.is_action_pressed("move_right"):
			velocity.x += move_force * delta;
		if Input.is_action_pressed("move_left"):
			velocity.x -= move_force * delta;
		if Input.is_action_pressed("jump") and is_on_floor():
			velocity.y -= jump_force * delta;
	return ret_vec;
