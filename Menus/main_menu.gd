extends Control


func _on_play_button_pressed() -> void:
	Globals.next_level()
	get_tree().change_scene_to_file(Globals.get_current_level_path())


func _on_quit_button_pressed() -> void:
	get_tree().quit()
