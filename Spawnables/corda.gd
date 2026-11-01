extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.add_rope()


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		body.remove_rope()
