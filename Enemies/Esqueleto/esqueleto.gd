class_name Skele
extends Enemy

func _physics_process(delta: float) -> void:
	dont_fall()
	handle_movement(delta)
