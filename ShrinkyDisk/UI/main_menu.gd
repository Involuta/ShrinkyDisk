extends Control

@onready var global = $/root/Global

func _on_play_pressed():
	global.shrink_time_remaining_secs = global.shrink_time_secs
	get_tree().change_scene_to_file("res://DriveLevel/drive_level.tscn")

func _on_lore_pressed():
	get_tree().change_scene_to_file("res://UI/lore_text.tscn")

func _on_quit_pressed():
	get_tree().quit()
