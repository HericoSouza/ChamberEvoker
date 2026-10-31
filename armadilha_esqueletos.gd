
extends Area2D

var HORDA_CENA = Globals.skele_horde

@onready var ponto_spawn: Marker2D = $SpawnPoint

var ativada = false
var encontro_concluido = false
var mago_atual: CharacterBody2D = null
var horda_atual: Node2D = null


func _ready() -> void:
	body_entered.connect(_ao_entrar)


func _ao_entrar(body: Node2D) -> void:
	if not body is CharacterBody2D:
		return

	if ativada:
		return

	ativada = true
	mago_atual = body
	body.set("poco_atual", self)

	horda_atual = HORDA_CENA.instantiate()
	get_tree().current_scene.add_child(horda_atual)

	horda_atual.global_position = ponto_spawn.global_position
	horda_atual.call("configurar", body, self)

	print("Armadilha ativada! A horda está avançando!")


func invocar_parede() -> void:
	if encontro_concluido:
		return

	if is_instance_valid(horda_atual):
		horda_atual.call("invocar_parede")
	else:
		print("Não há uma horda ativa para bloquear!")


func finalizar_encontro(personagem: CharacterBody2D) -> void:
	encontro_concluido = true

	if is_instance_valid(personagem):
		if personagem.get("poco_atual") == self:
			personagem.set("poco_atual", null)

	print("Armadilha superada!")
