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

	if $CollisionRay.is_colliding():
		self.target_angle = get_new_angle()
		rotate_self(target_angle - cur_angle)
	self.translate(forward * speed * delta)

func rotate_self(deg):
	forward = forward.rotated(deg2rad(deg))
	$CollisionRay.cast_to = Vector2(forward.x, -forward.y) * -50
#	$CollisionRay.cast_to = $CollisionRay.cast_to.rotated(deg2rad(deg))
	$TestingRay.cast_to = Vector2(-forward.x, forward.y) * 50
	$CollisionRay.force_raycast_update()
	$TestingRay.force_raycast_update()
	
	self.rotation_degrees += deg
	self.cur_angle += deg
	self.cur_angle = fmod(self.cur_angle, 360.0)

func get_new_angle():
	var direction = 1
	var test_angle = 1
	while $TestingRay.is_colliding() and abs(test_angle) < 90:
		$TestingRay.cast_to = $TestingRay.cast_to.rotated(test_angle * direction)
		$TestingRay.force_raycast_update()
		direction *= -1
		test_angle *= 1.5
	return self.target_angle + test_angle * direction
