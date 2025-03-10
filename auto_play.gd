extends Node


@export var is_auto_play: bool = false
var offset = 0.26625
var offset_decay = 0.001
var angle: float = 0:
	set(value):
		#angle = value + randf_range(-offset, offset) # arctan(6/22)
		angle = value


func _ready() -> void:
	BallVariables.max_speed_changed.connect(
		func (_value): if offset > offset_decay: offset -= offset_decay
	)


func init_auto_play():
	angle = BallVariables.direction.angle()


func update_auto_play():
	var next_ball_position = predict_next_ball_position()
	var v = next_ball_position - Global.center
	AutoPlay.angle = v.angle() 


func predict_next_ball_position() -> Vector2:
	var direction_with_magnitude = BallVariables.direction.dot(Global.center - BallVariables.prev_ball_position) * BallVariables.direction * 2 # vector point from prev_ball_position to next_ball_position
	return BallVariables.prev_ball_position + direction_with_magnitude
