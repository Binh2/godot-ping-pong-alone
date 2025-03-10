extends Node

signal max_speed_changed(value)

# For auto play
var prev_ball_position: Vector2
var direction: Vector2


# For ball and saving high score
var min_speed = 50
var default_max_speed = 100
@export var max_speed = default_max_speed:
	set(value):
		max_speed = value
		max_speed_changed.emit(value)

# For gameover
func reset_speed():
	max_speed = default_max_speed
