extends Node

var area
var player
var highlight

var active
const highlight_mod_speed = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	area = $InteractArea
	highlight = $InteractHighlight
	player = get_tree().get_root().get_child(0).get_player()
	highlight.modulate = Color(1, 1, 1, 0)
	area.connect("body_entered", self, "player_entered")
	area.connect("body_exited", self, "player_exited")
	area.connect("body_entered", player, "interact_area_entered", [self])
	area.connect("body_exited", player, "interact_area_exited", [self])
	

func _process(delta):
	if active:
		highlight.modulate.a += highlight_mod_speed * delta
		highlight.modulate.a = fmod(highlight.modulate.a, 1.0)

func interact(event):
	print("I have been interacted with!!!")
	print("The player did this event: ", event)

func player_entered(body):
	if body.name == "Player":
		self.active = true

func player_exited(body):
	if body.name == "Player":
		self.active = false
		highlight.modulate.a = 0
