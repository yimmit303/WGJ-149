extends Node2D

var animator


var speed = 10

var gender
var state
var state_change_cooldown = 1.0
var is_walking = false
var busy = false
var destination


# Called when the node enters the scene tree for the first time.
func _ready():
	self.gender = self.name.replace("PoliceOfficer_", "")
	self.gender.erase(len(gender) - 1, 1)
#	print(self.gender)
	self.animator = self.get_child(0)
	self.animator.animation = "Idle"
	animator.connect("animation_finished", self, "on_animation_finished")
	self.state = "Idle"
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not busy:	# The NPC is not doing something else
		state_change_cooldown -= delta
		if state_change_cooldown <= 0:
			state_change_cooldown = 1.0
			randomize()
			var rand_choice = randi() % 100
			if rand_choice == 0:
				var direction = 1
				if randf() > 0.5:
					direction *= -1
				self.set_destination(self.position + Vector2(32 * direction, 0))
			elif rand_choice == 1:
				pass
			else:
				make_idle()
				
	else:	# The NPC is busy, no state changes can happen until they are done
		if is_walking:
			var direction = self.position.direction_to(self.destination)
			self.position += direction * speed * delta
			
			animator.flip_h = false
			if direction.x == -1:
				animator.flip_h = true
			
			if self.position.distance_to(self.destination) <= 1:
				self.is_walking = false
				self.busy = false
				make_idle()

func set_destination(point):
	self.state = "Walking"
	self.animator.animation = "Walking"
	self.is_walking = true
	self.busy = true
	self.destination = point

func make_idle():
	self.state = "Idle"
	self.animator.animation = "Idle"

func on_animation_finished():
	match animator.animation:
		"Eating":
			busy = false
			print("Done eating")
		"Drinking":
			busy = false
			print("Done drinking")
		"RaiseHands":
			busy = false
			print("Done raising")
		_:
			return


