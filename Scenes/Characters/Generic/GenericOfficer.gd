extends Node2D

var animator
var gender


# Called when the node enters the scene tree for the first time.
func _ready():
	self.gender = self.name.replace("PoliceOfficer_", "")
	self.gender.erase(len(gender) - 1, 1)
	print(self.gender)
	self.animator = self.get_child(0)
	self.animator.animation = "Idle"
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
