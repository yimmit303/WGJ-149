extends Node

signal player_interacted(interactable, type, details)

# Node refs
var area
var player
var highlight
var arrow

# State variables
var active = false
var goal = false
const highlight_mod_speed = 1

# Interactable Details
var type
var details
var text_format

# Called when the node enters the scene tree for the first time.
func _ready():
	area = $InteractArea
	highlight = $InteractHighlight
	arrow = $Arrow
	arrow.visible = false
	player = get_tree().get_root().get_child(0).get_player()
	highlight.modulate = Color(1, 1, 1, 0)
	area.connect("body_entered", self, "player_entered")
	area.connect("body_exited", self, "player_exited")
	area.connect("body_entered", player, "interact_area_entered", [self])
	area.connect("body_exited", player, "interact_area_exited", [self])
	self.connect("player_interacted", get_tree().get_root().get_child(0).get_objective_list(), "on_player_interacted")

func _process(delta):
	if active and goal:
		highlight.modulate.a += highlight_mod_speed * delta
		highlight.modulate.a = fmod(highlight.modulate.a, 1.0)

func make_goal():
	arrow.visible = true
	goal = true

func complete():
	arrow.visible = false
	goal = false
	highlight.modulate.a = 0

func interact(event):
	print("I have been interacted with!!!")
	
func get_formatted_text():
	return text_format

func player_entered(body):
	if body.name == "Player":
		self.active = true

func player_exited(body):
	if body.name == "Player":
		self.active = false
		highlight.modulate.a = 0
