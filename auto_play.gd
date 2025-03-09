extends Node


@export var is_auto_play: bool = true
var offset = 0.26625
var offset_decay = 0.0005
var auto_play_angle: float = 0:
	set(value):
		#auto_play_angle = value + randf_range(-offset, offset) # arctan(6/22)
		auto_play_angle = value + offset
		#auto_play_angle = value

func _ready() -> void:
	BallVariables.speed_changed.connect(
		func (_value): if offset > offset_decay: offset -= offset_decay
	)
