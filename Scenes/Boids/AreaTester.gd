extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():	
	$Tween.interpolate_property(	self, "position", self.position, self.position + Vector2(0, -100),
									1, Tween.TRANS_LINEAR)
	$Tween.start()
	yield($Tween, "tween_completed")
#	self.position += Vector2(0, -10) * delta
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_Area2D_area_entered(area):
	print("Area ENTERED!!!")


func _on_Area2D_area_exited(area):
	print("Area EXITED!!!")
