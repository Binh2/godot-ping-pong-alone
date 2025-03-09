extends Node2D


func _on_out_of_bound_area_entered(_area: Area2D) -> void:
	#if area.is_in_group("Ball"):
	gameover()


func gameover():
	print("gameover")
	save_to_file()
	BallVariables.reset_speed()
	get_tree().call_deferred("reload_current_scene")


func save_to_file():
	var score = BallVariables.speed
	var json = JSON.new()
	var json_string = json.stringify({
		"high_score": score
	})
	var cfg_file = FileAccess.open("data.cfg", FileAccess.WRITE)
	var content = load_from_file()
	var prev_high_score
	if content:
		prev_high_score = content["high_score"]
	if !prev_high_score || prev_high_score < score:
		cfg_file.store_line(json_string)
	cfg_file.close()

func load_from_file():
	var cfg_file = FileAccess.open("data.cfg", FileAccess.READ)
	var json = JSON.new()
	return json.parse_string(cfg_file.get_as_text())
	
	
