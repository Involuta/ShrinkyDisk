extends Control

func _process(delta):
	if Input.is_action_just_pressed("ReturnToMenu"):
		get_tree().change_scene_to_file("res://UI/main_menu.tscn")
