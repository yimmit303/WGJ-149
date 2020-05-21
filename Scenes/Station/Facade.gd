extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var faded = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !faded:
		faded = true
		$Tween.interpolate_property($Facade_Walls, "modulate", Color(1,1,1,1), Color(1,1,1,0), 0.5, Tween.TRANS_LINEAR)
		$Tween.start()
