class_name Player
extends CharacterBody2D

const VELOCIDADE = 220.0
const GRAVIDADE = 980.0
const VELOCIDADE_PULO = -1100.0

var rope_count: int = 0
var pendurado_na_corda = false

@onready var ui = $CanvasLayer/PlayerUi
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

@onready var teleport: AnimatedSprite2D = $Teleport

var invocando: bool = false
var morrendo: bool = false
#fica true até o teleporte de entrada na fase acabar
var chegando: bool = true
#quadro do teleporte em que o feixe cobre o jogador
const TELEPORT_REVEAL_FRAME: int = 3

@export_category("Mana")
@export var mana: int = 100
@export var max_mana: int = 100


var curr_selected_spawnable: spawnable = spawnable.NONE

@export_category("Mana Cossts")
@export var bridge_cost: int = 30
@export var rope_cost: int = 20
@export var wall_cost: int = 10

var bridge_scene: PackedScene = Globals.bridge
var rope_scene: PackedScene = Globals.rope
var wall_scene: PackedScene = Globals.wall
var rune_scene: PackedScene = Globals.rune_effect

#eu provavelmente deveria botar pra ele setar os bounds no fantasma
#baseado nisso também
var bridge_snapping: Vector2 = Vector2(64,8)
var rope_snapping: Vector2 = Vector2(8,16)
var wall_snapping: Vector2 = Vector2(8,8)

enum spawnable {
	BRIDGE,ROPE,WALL,NONE
}

var build_ghost: GhostSpawnable = null
@onready var ghost_layer: CanvasLayer = $GhostLayer

#Só pra isso não ficar dificultando minha vida quando eu tiver editando fase
func _ready() -> void:
	ui.visible = true
	sprite.visible = false

func _physics_process(delta: float) -> void:

	if pendurado_na_corda || is_on_floor():
		velocity.y = 0.0
	else:
		velocity.y += GRAVIDADE * delta
	#me recordo de que era pra ele não poder pular então tirei a parte do pulo
	if (chegando):
		start_teleport()
	else:
		handle_controls()
	move_and_slide()

func falhar() -> void:
	if (morrendo):
		return
	morrendo = true
	print("Falha! A fase será reiniciada.")
	set_physics_process(false)
	sprite.visible = true
	teleport.visible = false
	sprite.play("death")

func _on_animation_finished() -> void:
	match sprite.animation:
		"summon":
			invocando = false
		"death":
			get_tree().reload_current_scene()

#algumas fases começam com o jogador no ar, então espera ele pousar
func start_teleport() -> void:
	if (is_on_floor() && !teleport.visible):
		teleport.visible = true
		teleport.play("default")

func _on_teleport_frame_changed() -> void:
	if (teleport.frame >= TELEPORT_REVEAL_FRAME):
		sprite.visible = true

func _on_teleport_finished() -> void:
	teleport.visible = false
	chegando = false

func update_animation(dir: float) -> void:
	if (invocando):
		return
	if dir:
		sprite.flip_h = dir < 0
	var movendo: bool = dir != 0 or (pendurado_na_corda and velocity.y != 0)
	sprite.play("walk" if movendo else "idle")

func spawn_rune(pos: Vector2) -> void:
	var r: AnimatedSprite2D = rune_scene.instantiate()
	r.global_position = pos
	add_sibling(r)
	match curr_selected_spawnable:
		spawnable.BRIDGE:
			r.play("bridge")
		spawnable.ROPE:
			r.play("rope")
		spawnable.WALL:
			r.play("wall")

func play_summon() -> void:
	invocando = true
	sprite.flip_h = get_global_mouse_position().x < global_position.x
	sprite.play("summon")

func handle_controls() -> void:
	var dir := Input.get_axis("a","d")
	if dir:
		velocity.x = dir*VELOCIDADE
	else:
		velocity.x = move_toward(velocity.x, 0.0, VELOCIDADE)
	if (Input.is_action_just_pressed("r")):
		get_tree().reload_current_scene()
	if (pendurado_na_corda):
		var upward := Input.get_axis("w","s")
		velocity.y = upward*VELOCIDADE
	if (Input.is_action_just_pressed("esc")):
		get_tree().change_scene_to_file(Globals.main_menu_path)
	update_animation(dir)
func handle_spawns() -> void:
	var s: Node2D
	match curr_selected_spawnable:
		spawnable.NONE:
			return
		spawnable.BRIDGE:
			if (bridge_cost <= mana):
				mana -= bridge_cost
				s = bridge_scene.instantiate()
				s.global_position = get_global_mouse_position().snapped(bridge_snapping)
		spawnable.ROPE:
			if (rope_cost <= mana):
				mana -= rope_cost
				s = rope_scene.instantiate()
				s.global_position = get_global_mouse_position().snapped(rope_snapping)
		spawnable.WALL:
			if (wall_cost <= mana):
				mana -= wall_cost
				s = wall_scene.instantiate()
				s.global_position = get_global_mouse_position().snapped(wall_snapping)
	add_sibling(s)
	if (s):
		play_summon()
		spawn_rune(s.global_position)
	curr_selected_spawnable = spawnable.NONE
	remove_ghost()

func create_ghost() -> void:
	remove_ghost()
	match curr_selected_spawnable:
		spawnable.NONE:
			return
		spawnable.BRIDGE:
			if (bridge_cost <= mana):
				var g: GhostSpawnable = Globals.ghost_bridge.instantiate()
				ghost_layer.add_child(g)
				build_ghost = g
		spawnable.ROPE:
			if (rope_cost <= mana):
				var g: GhostSpawnable = Globals.ghost_rope.instantiate()
				ghost_layer.add_child(g)
				build_ghost = g
		spawnable.WALL:
			if (wall_cost <= mana):
				var g: GhostSpawnable = Globals.ghost_wall.instantiate()
				ghost_layer.add_child(g)
				build_ghost = g

func remove_ghost() -> void:
	if (build_ghost):
		build_ghost.die()
		build_ghost = null

func clear_build() -> void:
	curr_selected_spawnable = spawnable.NONE
	remove_ghost()

func _unhandled_input(event: InputEvent) -> void:
	if (morrendo):
		return
	if (event is InputEventMouseButton && event.is_pressed()):
		if (event.button_index == MOUSE_BUTTON_LEFT):
			handle_spawns()
		elif (event.button_index == MOUSE_BUTTON_RIGHT):
			clear_build()

func add_rope() -> void:
	rope_count += 1
	pendurado_na_corda = true

func remove_rope() -> void:
	rope_count -= 1
	if (rope_count == 0):
		pendurado_na_corda = false 
