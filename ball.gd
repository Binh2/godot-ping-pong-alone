extends Node2D


var direction: Vector2

var ball_radius = 8
var circle_color = Color.BLACK
var is_recently_touch = false
var timeout_time = 0.05
var prev_ball_position
var acceleration = 10
var speed = 100


func _draw() -> void:
	draw_circle(Vector2.ZERO, ball_radius, circle_color)


func _ready() -> void:
	position = Global.center
	direction = Vector2.LEFT.rotated(randf_range(-PI, PI))
	
	BallVariables.direction = direction
	AutoPlay.init_auto_play()


func _process(delta: float) -> void:
	if speed < BallVariables.max_speed:
		speed += acceleration
	elif speed > BallVariables.max_speed:
		speed = BallVariables.max_speed
	print(speed)
	position += direction * speed * delta


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if !is_recently_touch:
			var normal_vector = get_unit_vector(PlayerVariables.angle)
			direction = direction - 2 * direction.dot(normal_vector) * normal_vector
			print("Collided")
			
			BallVariables.direction = direction
			BallVariables.prev_ball_position = position
			AutoPlay.update_auto_play()
			
			BallVariables.max_speed += 10
			print(BallVariables.max_speed)
			speed = BallVariables.min_speed
			
			is_recently_touch = true
			$Timer.start(timeout_time)


func _on_timer_timeout() -> void:
	is_recently_touch = false


func get_unit_vector(angle: float):
	return Vector2(cos(angle), sin(angle))
