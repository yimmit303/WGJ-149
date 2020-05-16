extends Node2D


var forward = Vector2(0, -1)
var speed = 100
var turn_speed = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $RayCast2D.get_collider() != null:
		rotate_self(90)
	self.translate(forward * speed * delta)


func rotate_self(deg):
	forward = forward.rotated(deg2rad(deg))
	self.rotation_degrees += deg

func get_new_angle():
	pass
