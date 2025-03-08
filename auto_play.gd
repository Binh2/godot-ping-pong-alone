extends Node


@export var is_auto_play: bool = true
var auto_play_angle: float = 0:
	set(value):
		#auto_play_angle = value + randf_range(-0.26625, 0.26625) # arctan(6/22)
		#auto_play_angle = value + 0.2662
		auto_play_angle = value
