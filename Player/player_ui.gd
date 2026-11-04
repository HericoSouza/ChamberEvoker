extends Control

@onready var mana_bar: ProgressBar = $ManaBar
@export var player: Player
@onready var bridge_label := $ColorRect/HBoxContainer/VBoxContainer/BridgeLabel
@onready var wall_label := $ColorRect/HBoxContainer/VBoxContainer2/WallLabel
@onready var rope_label := $ColorRect/HBoxContainer/VBoxContainer3/RopeLabel
@onready var mana_label := $ManaBar/ManaLabel

@onready var bridge_button := $ColorRect/HBoxContainer/VBoxContainer/BridgeButton
@onready var wall_button := $ColorRect/HBoxContainer/VBoxContainer2/WallButton
@onready var rope_button := $ColorRect/HBoxContainer/VBoxContainer3/RopeButton
func _ready() -> void:
	if (player):
		mana_bar.max_value = player.max_mana
		bridge_label.text = str(player.bridge_cost)
		wall_label.text = str(player.wall_cost)
		rope_label.text = str(player.rope_cost)
	else:
		print("ALERTA: PLAYER NÃO SETADO. AJEITE NO EXPORT DE PLAYER.")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#isso é ruim. não faça isso num projeto de verdade.
#o correto seria fazer um método que atualiza o elemento da ui
#e chamar ele com algum método, provavelmente no player.
func _process(_delta: float) -> void:
	if (player):
		mana_bar.value = player.mana
		mana_label.text = str(player.mana)


func _on_bridge_button_pressed() -> void:
	if (player):
		player.curr_selected_spawnable = Player.spawnable.BRIDGE
		player.create_ghost()


func _on_wall_button_pressed() -> void:
	if (player):
		player.curr_selected_spawnable = Player.spawnable.WALL
		player.create_ghost()


func _on_rope_button_pressed() -> void:
	if (player):
		player.curr_selected_spawnable = Player.spawnable.ROPE
		player.create_ghost()

func untoggle_buttons() -> void:
	bridge_button.set_pressed_no_signal(false)
	wall_button.set_pressed_no_signal(false)
	rope_button.set_pressed_no_signal(false)
