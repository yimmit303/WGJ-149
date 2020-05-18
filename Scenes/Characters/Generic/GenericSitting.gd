extends Node2D

enum Behavior {ALWAYS_IDLE, ALWAYS_USE, RANDOM}
export(Behavior) var behavior

export(float, 0.1, 0.9, 0.1) var idle_amount = 0.5

var animator

var switch_timer = 1.0

func _ready():
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
