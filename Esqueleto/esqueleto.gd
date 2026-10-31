
extends Area2D

func _ready() -> void:
	body_entered.connect(_ao_entrar)


func _ao_entrar(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body.has_method("falhar"):
			body.call("falhar")
