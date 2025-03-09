extends Node2D


var angle_speed: float = 10
var center: Vector2
var prev_mouse_position: Vector2


func get_angle() -> float:
	if AutoPlay.is_auto_play:
		return AutoPlay.auto_play_angle
	return (get_viewport().get_mouse_position() - center).angle() 


func _ready() -> void:
	prev_mouse_position = get_viewport().get_mouse_position()
	center = get_viewport_rect().size / 2
	PlayerVariables.angle = get_angle()


func _process(delta: float) -> void:
	position = center
	PlayerVariables.angle = get_angle()
	#var old_rotation = rotation
	var rotation_change = (PlayerVariables.angle - rotation) * angle_speed * delta
	rotation += rotation_change
	
	# To fix the bug of the player jumping when angle switch from -PI to PI
	if !AutoPlay.is_auto_play:
		var mouse_position = get_viewport().get_mouse_position()
		if prev_mouse_position.x < center.x && mouse_position.x < center.x:
			if prev_mouse_position.y < center.y && mouse_position.y >= center.y: # Mouse move from top left to bottom left
				rotation += 2 * PI
				rotation -= rotation_change
			elif prev_mouse_position.y > center.y && mouse_position.y <= center.y: # Mouse move from bottom left to top left
				rotation -= 2 * PI
				rotation -= rotation_change
		prev_mouse_position = mouse_position
	
	
