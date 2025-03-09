extends Node2D

var center: Vector2
var direction: Vector2

var ball_radius = 8
var circle_color = Color.BLACK
var is_recently_touch = false
var timeout_time = 0.05
var prev_ball_position


func _draw() -> void:
	draw_circle(Vector2.ZERO, ball_radius, circle_color)


func _ready() -> void:
	center = get_viewport_rect().size / 2
	position = center
	direction = Vector2.LEFT.rotated(randf_range(-PI, PI))
	AutoPlay.auto_play_angle = direction.angle()


func _process(delta: float) -> void:
	position += direction * BallVariables.speed * delta


func get_unit_vector(angle: float):
	return Vector2(cos(angle), sin(angle))


func predict_next_ball_position() -> Vector2:
	var direction_with_magnitude = direction.dot(center - prev_ball_position) * direction * 2 # vector point from prev_ball_position to next_ball_position
	return prev_ball_position + direction_with_magnitude

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if !is_recently_touch:
			var normal_vector = get_unit_vector(PlayerVariables.angle)
			direction = direction - 2 * direction.dot(normal_vector) * normal_vector
			print("Collided")
			
			prev_ball_position = position
			var next_ball_position = predict_next_ball_position()
			var v = next_ball_position - center
			AutoPlay.auto_play_angle = v.angle() 
			
			BallVariables.speed += 10
			print(BallVariables.speed)
			
			is_recently_touch = true
			$Timer.start(timeout_time)


func _on_timer_timeout() -> void:
	is_recently_touch = false
