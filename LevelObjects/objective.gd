class_name Objective
extends Area2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var current_buttons = 0
@export var needed_buttons = 0

func _ready() -> void:
	if (needed_buttons > 0):
		sprite.modulate = Color.DIM_GRAY
		monitoring = false
	else:
		sprite.play("open")

func _on_animation_finished() -> void:
	match sprite.animation:
		"open":
			sprite.play("idle")
		"close":
			#trancado: o portal fica cinza e parado
			sprite.animation = "idle"

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		Globals.next_level()
		var tree = get_tree()
		tree.call_deferred("change_scene_to_file", Globals.get_current_level_path())

func button_pressed() -> void:
	current_buttons += 1
	if (current_buttons >= needed_buttons && !monitoring):
		sprite.modulate = Color.WHITE
		monitoring = true
		sprite.play("open")

func button_unpressed() -> void:
	current_buttons -= 1
	if (current_buttons < needed_buttons && monitoring):
		sprite.modulate = Color.DIM_GRAY
		monitoring = false
		sprite.play("close")
