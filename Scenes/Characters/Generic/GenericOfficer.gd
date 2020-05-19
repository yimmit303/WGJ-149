extends Node2D

var animator
var navpoint_container
var num_navpoints

var speed = 20

var gender
var state
var state_change_cooldown = 1.0
var is_walking = false
var busy = false
var can_drink = false

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
	
	self.navpoint_container = get_node("../Navpoints")
	if self.navpoint_container != null:
		self.num_navpoints = navpoint_container.get_child_count()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not busy:	# The NPC is not doing something else
		if can_drink:
			drink_water()
			can_drink = false
			return
		state_change_cooldown -= delta
		if state_change_cooldown <= 0:
			state_change_cooldown = 1.0
			randomize()
			var rand_choice = randi() % 3
			if rand_choice == 0: # decides to walk
				
				if self.navpoint_container == null:
					print("Failed to walk, no navpoints available")
					return
				
				var rand_navpoint_idx = randi() % (num_navpoints - 1)
				var navpoint = navpoint_container.get_child(rand_navpoint_idx)
				if navpoint.get_type() == "Water":
					self.can_drink = true
				self.set_destination(navpoint.global_position)
				
			elif rand_choice == 1: # decides to eat
				pass
			else:
				make_idle()
				
	else:	# The NPC is busy, no state changes can happen until they are done
		if is_walking:
			var direction = self.global_position.direction_to(self.destination)
			if direction.x > 0:
				direction.x = ceil(direction.x)
			else:
				direction.x = floor(direction.x)
			direction.y = 0
			self.global_position += direction * speed * delta
			
			animator.flip_h = false
			if direction.x == -1:
				animator.flip_h = true
			if abs(self.global_position.x - self.destination.x) <= 1:
				self.is_walking = false
				self.busy = false
				make_idle()

func set_destination(point):
	print("My destination is ", point)
	print("My position is ", self.position)
	print("My global position is ", self.global_position)
	self.state = "Walking"
	self.animator.animation = "Walking"
	self.is_walking = true
	self.busy = true
	self.destination = point

func make_idle():
	self.state = "Idle"
	self.animator.animation = "Idle"

func drink_water():
	self.state = "Drinking"
	self.busy = true
	self.animator.animation = "Drinking"
	# TODO: Random chance to spill water

func on_animation_finished():
	match animator.animation:
		"Eating":
			busy = false
			print("Done eating")
		"Drinking":
			busy = false
			make_idle()
			print("Done drinking")
		"RaiseHands":
			busy = false
			print("Done raising")
		_:
			return


