extends Node2D

export(int, 1, 5) var floor_num = 1

func _ready():
	$Elevator.floor_num = floor_num
