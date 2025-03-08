extends Node2D

var center: Vector2
var direction: Vector2
var speed = 50

func _draw() -> void:
	draw_circle(Vector2.ZERO, 8, Color.BLACK)

func _ready() -> void:
	center = get_viewport_rect().size / 2
	position = center
	direction = Vector2.LEFT.rotated(randf_range(-PI, PI))

func _process(delta: float) -> void:
	position += direction * speed * delta
