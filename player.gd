extends Node2D


@export var angle: float
var angle_speed: float = 10
var center: Vector2
var prev_mouse_position: Vector2


func get_angle() -> float:
	return (get_viewport().get_mouse_position() - center).angle() 


func _ready() -> void:
	prev_mouse_position = get_viewport().get_mouse_position()
	center = get_viewport_rect().size / 2
	angle = get_angle()


func _process(delta: float) -> void:
	position = center
	angle = get_angle()
	var rotation_change = (angle - rotation) * angle_speed * delta
	rotation += rotation_change
	
	# To fix the bug of the player jumping when angle switch from -PI to PI
	var mouse_position = get_viewport().get_mouse_position()
	if prev_mouse_position.x < center.x && mouse_position.x < center.x:
		if prev_mouse_position.y < center.y && mouse_position.y >= center.y: # Mouse move from top left to bottom left
			rotation += 2 * PI
			rotation -= rotation_change
		elif prev_mouse_position.y > center.y && mouse_position.y <= center.y: # Mouse move from bottom left to top left
			rotation -= 2 * PI
			rotation -= rotation_change
	
	prev_mouse_position = mouse_position
