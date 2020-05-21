extends "res://Scenes/Interactables/Interactable.gd"

enum Behavior {ALWAYS_IDLE, ALWAYS_USE, RANDOM}
export(Behavior) var behavior

export(float, 0.1, 0.9, 0.1) var idle_amount = 0.5

var animator

var switch_timer = 1.0

func _ready():
	type = "Character"
	details = ["Linda"]

	text_format = "Talk to Linda"
	animator = self.get_child(1)
	if behavior == Behavior.ALWAYS_IDLE:
		self.animator.animation = "NotUse"
	elif behavior == Behavior.ALWAYS_USE:
		self.animator.animation = "Use"

func _process(delta):
	if behavior == Behavior.RANDOM:
		switch_timer -= delta
		if switch_timer <= 0:
			switch_timer = 1.0
			if randf() > idle_amount:
				self.animator.animation = "Use"
			else:
				self.animator.animation = "NotUse"

func interact(event):
	if goal:
		if event is InputEventKey and event.pressed == true and event.echo == false and event.scancode == KEY_E:
			emit_signal("player_interacted", self, type, details)

func make_goal():
	.make_goal()
	if len(player.inventory) > 0:
		var item = player.inventory[0]
		details.append(item)
		text_format = "Give the " + item + " to Linda"
	else:
		text_format = "Talk to Linda"

func get_formatted_text():
	return text_format
