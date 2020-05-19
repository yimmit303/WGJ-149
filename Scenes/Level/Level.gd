extends Node2D

signal camera_finsished

export(NodePath) var player_path

var days_left = 5

var wait_a_sec = 5
var animated = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera.position = Vector2(960, -540)
	$Camera.zoom = Vector2(.8, .8)
	# TODO
#	$LevelTween.interpolate_property(	get_node("ParallaxBackground/BGParallax/SkyPlaceholder/DayCounter"), "modulate",
#										Color(1,1,1,0), Color(1,1,1,1), 3.0, Tween.TRANS_EXPO)
#	$LevelTween.interpolate_property(	get_node("ParallaxBackground/BGParallax/SkyPlaceholder/DayCounter"), "percent_visible",
#										0, 1, 3.0, Tween.TRANS_LINEAR)
#	$LevelTween.start()
#	yield($LevelTween, "tween_all_completed")
	start_camera()
	

func _process(delta):
	pass

func start_camera():
	pan_camera()
	yield($LevelTween, "tween_all_completed")
	self.emit_signal("camera_finsished")

func pan_camera():
	var animation_time = 2.0
	var tween_type = Tween.TRANS_CUBIC
	var ease_type = Tween.EASE_IN_OUT
	$LevelTween.interpolate_property(	$Camera, "position", $Camera.position, Vector2(960, 540), 
										animation_time, tween_type, ease_type)
	$LevelTween.interpolate_property(	$Camera, "zoom", $Camera.zoom, Vector2(1,1), 
										animation_time, tween_type, ease_type)
	$LevelTween.start()

func get_player():
	return get_node(player_path)
