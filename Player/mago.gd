class_name Player
extends CharacterBody2D

const VELOCIDADE = 220.0
const GRAVIDADE = 980.0
const VELOCIDADE_PULO = -1100.0
const TEMPO_ATE_REINICIAR = 0.8

var poco_atual: Area2D = null
var pendurado_na_corda = false
var altura_pendurado: float = 0.0
var suporte_corda: Area2D = null

@onready var ui = $PlayerUi
var mana: float = 100
var max_mana: float = 100
var curr_selected_spawnable: spawnable = spawnable.NONE

var bridge_cost: float = 30
var rope_cost: float
var cage_cost: float

var bridge_scene: PackedScene = Globals.bridge
var rope_scene: PackedScene
var cage_scene: PackedScene

enum spawnable {
	BRIDGE,ROPE,CAGE,NONE
}

func _physics_process(delta: float) -> void:
	handle_controls(delta)

	if pendurado_na_corda:
		velocity.y = 0.0
		global_position.y = altura_pendurado
	elif is_on_floor():
		velocity.y = 0.0
	else:
		velocity.y += GRAVIDADE * delta
	#me recordo de que era pra ele não poder pular então tirei a parte do pulo

	move_and_slide()


func iniciar_pendurado(altura: float, obstaculo: Area2D) -> void:
	pendurado_na_corda = true
	altura_pendurado = altura
	suporte_corda = obstaculo
	velocity.y = 0.0
	global_position.y = altura_pendurado


func liberar_corda() -> void:
	pendurado_na_corda = false
	suporte_corda = null
	velocity.y = 0.0

func falhar() -> void:

	print("Falha! A fase será reiniciada.")

	get_tree().reload_current_scene()

func handle_controls(delta: float) -> void:
	var dir := Input.get_axis("a","d")
	if dir:
		velocity.x = dir*VELOCIDADE
	else:
		velocity.x = move_toward(velocity.x, 0.0, VELOCIDADE)
	if (Input.is_action_just_pressed("mouse1")):
		handle_spawns()
	if (Input.is_action_just_pressed("r")):
		falhar()

func handle_spawns() -> void:
	match curr_selected_spawnable:
		spawnable.NONE:
			return
		spawnable.BRIDGE:
			if (bridge_cost <= mana):
				mana -= bridge_cost
				var s: StaticBody2D = bridge_scene.instantiate()
				s.global_position = get_global_mouse_position()
				add_sibling(s)
				curr_selected_spawnable = spawnable.NONE
		#fazer o mesmo pra esses 2
		spawnable.ROPE:
			pass
		spawnable.CAGE:
			pass
