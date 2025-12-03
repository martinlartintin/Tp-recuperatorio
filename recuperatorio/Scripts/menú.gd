extends Control

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ENTER"):
		get_tree().change_scene_to_file("res://Scenes/level.tscn")
		Global.game_timer = 90

	if event.is_action_pressed("DELETE"):
		get_tree().quit()
