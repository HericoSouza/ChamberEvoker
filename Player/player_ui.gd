extends Control

@onready var mana_bar: ProgressBar = $ManaBar
@export var player: Player


func _ready() -> void:
	if (player):
		mana_bar.max_value = player.max_mana

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (player):
		mana_bar.value = player.mana


func _on_bridge_button_pressed() -> void:
	if (player):
		player.curr_selected_spawnable = Player.spawnable.BRIDGE


func _on_cage_button_pressed() -> void:
	if (player):
		player.curr_selected_spawnable = Player.spawnable.CAGE


func _on_rope_button_pressed() -> void:
	if (player):
		player.curr_selected_spawnable = Player.spawnable.ROPE
