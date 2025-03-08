extends Node2D

var center: Vector2
var direction: Vector2

@export var speed = 100
var circle_radius = 8
var circle_color = Color.BLACK
var is_recently_touch = false
var timeout_time = 0.1


func _draw() -> void:
	draw_circle(Vector2.ZERO, circle_radius, circle_color)


func _ready() -> void:
	center = get_viewport_rect().size / 2
	position = center
	direction = Vector2.LEFT.rotated(randf_range(-PI, PI))
	AutoPlay.auto_play_angle = direction.angle()


func _process(delta: float) -> void:
	position += direction * speed * delta


func get_unit_vector(angle: float):
	return Vector2(cos(angle), sin(angle))


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if !is_recently_touch:
			var normal_vector = get_unit_vector(PlayerVariables.angle)
			direction = direction - 2 * direction.dot(normal_vector) * normal_vector
			print("Collide")
			AutoPlay.auto_play_angle = direction.angle()
			is_recently_touch = true
			$Timer.start(timeout_time)


func _on_timer_timeout() -> void:
	is_recently_touch = false
