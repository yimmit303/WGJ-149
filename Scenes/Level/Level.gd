extends Node2D

signal camera_finsished

var cur_level = 1

var wait_a_sec = 1
var animated = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera.position = $Player.position
	$Camera.zoom = Vector2(.25,.25)

func _process(delta):
	wait_a_sec -= delta
	if wait_a_sec <= 0 and !animated:
		animated = true
		animate_camera()
		yield($LevelTween, "tween_all_completed")
		self.emit_signal("camera_finsished")

func animate_camera():
	var animation_time = 0.5
	$LevelTween.interpolate_property(	$Camera, "position", $Camera.position, Vector2(960, 540), 
										animation_time, Tween.TRANS_BACK, Tween.EASE_OUT)
	$LevelTween.interpolate_property(	$Camera, "zoom", $Camera.zoom, Vector2(1,1), 
										animation_time, Tween.TRANS_BACK, Tween.EASE_OUT)
	$LevelTween.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
