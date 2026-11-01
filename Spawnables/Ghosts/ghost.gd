class_name GhostSpawnable
extends Sprite2D

@export var snap: Vector2 = Vector2.ZERO
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	global_position = get_global_mouse_position().snapped(snap)

func die() -> void:
	queue_free()
