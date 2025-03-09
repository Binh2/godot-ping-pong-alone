extends Node

signal speed_changed(value)
var default_speed = 100
@export var speed = default_speed:
	set(value):
		speed = value
		speed_changed.emit(value)

func reset_speed():
	speed = default_speed
