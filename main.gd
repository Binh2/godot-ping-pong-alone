extends Node2D


func _on_area_2d_area_entered(_area: Area2D) -> void:
	gameover()


func gameover():
	print("gameover")
	get_tree().call_deferred("reload_current_scene")
