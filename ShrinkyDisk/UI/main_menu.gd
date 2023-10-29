extends Control

func _on_play_pressed():
	get_tree().change_scene_to_file("res://DriveLevel/drive_level.tscn")

func _on_lore_pressed():
	get_tree().change_scene_to_file("res://UI/lore_text.tscn")

func _on_quit_pressed():
	get_tree().quit()
