extends Node2D


var forward = Vector2(0, -1)
var cur_angle = 90
var speed = 100
var turn_speed = 1

var target_angle = 90


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $CollisionRay.get_collider() != null:
		print("colliding!!!")
		self.target_angle = get_new_angle()
		rotate_self(cur_angle - target_angle)
	self.translate(forward * speed * delta)

func rotate_self(deg):
	forward = forward.rotated(deg2rad(deg))
	print(forward * 50)
	$CollisionRay.cast_to = forward * 2
	$TestingRay.cast_to = $CollisionRay.cast_to
	self.rotation_degrees += deg
	self.cur_angle += deg
	self.cur_angle % 360

func get_new_angle():
	var direction = 1
	var test_angle = 1
	while $TestingRay.get_collider() != null or abs(test_angle) > 90:
		$TestingRay.cast_to = forward.rotated(deg2rad(test_angle))
		direction *= -1
		test_angle *= 1.5
	print(self.target_angle + test_angle)
	return self.target_angle + test_angle
