extends Control


func _on_play_button_pressed() -> void:
	if Globals.current_level < 1:
		Globals.next_level()
	get_tree().change_scene_to_file(Globals.get_current_level_path())


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Master"), value)
