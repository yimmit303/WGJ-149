extends KinematicBody2D
var gravity = Vector2(0, 9.81);
var velocity = Vector2();
var sprint_max = 200.0;
var walk_max = 90.0;
var cur_max = walk_max;
var friction = 0.17;
var move_force = 75;
var stun_timer = 2.0;
var slip_timer = 0.0;
var stunned = false;
var lock_movement = false;
var facing_left = false;
var lock_timer = 0.0;
var puddle_dir = Vector2();
var animator;
func _ready():
	animator = get_node("JohnMorgan_Sprite");
	animator.animation = "Idle";
	animator.connect("animation_finished", self, "on_animation_finished");
	
func _physics_process(delta):
	velocity += gravity * 1.6;
	if not lock_movement and not stunned:
		var dir_vec = process_input();
		velocity += dir_vec;
	else:
		if (velocity + puddle_dir).length_squared() < pow(cur_max, 2):
			velocity += puddle_dir;
	effect_timer(delta);
	if stunned:
		velocity = Vector2();
	velocity = move_and_slide(velocity, Vector2.UP);

func effect_timer(delta):
		if lock_movement:
			lock_timer += delta;
			if lock_timer >= stun_timer:
				lock_movement = false;
				lock_timer = 0.0;


func process_input():
	var tmp_vel = velocity;
	var ret_vec = Vector2();
	var moved = false;
	var sprinting = false;
	if not stunned:
		if Input.is_action_pressed("sprint"):
			cur_max = sprint_max;
			sprinting = true;
		else:
			cur_max = walk_max;
		if Input.is_action_pressed("move_right"):
			if facing_left:
				scale.x = -1;
				facing_left = false;
			tmp_vel.x += move_force;
			if tmp_vel.length_squared() < pow(cur_max, 2):
				velocity.x += move_force;
				moved = true;
		elif Input.is_action_pressed("move_left"):
			if not facing_left:
				scale.x = -1;
				facing_left = true;
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
	if not moved and velocity.length_squared() <= 300:
		# Stops the velocity if it gets below min-threshold and not moving
		velocity.x = 0;
		animator.animation = "Idle";
	if moved:
		animator.animation = "Walking";
	return ret_vec;
	
func on_banana_slip(body):
	#print("Wow, who could've seen that one coming?");
	animator.animation = "Slip";
	stunned = true;

func on_anvil_hit(body):
	stunned = true;
	animator.animation = "Slip";

func on_puddle_slip(body):
	#print("woah, we hydroplaning.");
	animator.animation = "Slip";
	lock_movement = true;
	puddle_dir = process_input();

func on_wire_trip(body):
	animator.animation = "Shock";
	stunned = true;
	#print("Wow, shocking.");

func on_glass_trip(body):
	animator.animation = "Slip";
	stunned = true;
	#print("Ouch! #!");
	
func on_animation_finished():
	match animator.animation:
		"Shock":
			animator.animation = "Stun";
			stunned = true;
		"Slip":
			animator.animation = "Idle";
			stunned = false;
			slip_timer = 0.0;
		"Stun":
			animator.animation = "Idle";
			stunned = false;
		_:
			return
