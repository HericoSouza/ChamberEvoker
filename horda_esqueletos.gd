
extends Node2D

const VELOCIDADE_HORDA = 100.0
const DURACAO_EMERSAO = 0.45
const ALTURA_EMERSAO = 55.0
const PAREDE_CENA = preload("res://parede_horda.tscn")

var mago: CharacterBody2D = null
var armadilha: Area2D = null
var parede_invocada = false
var parede_instanciada: Area2D = null

var altura_inicial = 0.0
var altura_final = 0.0
var tempo_emersao = 0.0
var encontro_concluido = false


func configurar(personagem: CharacterBody2D, origem: Area2D) -> void:
	mago = personagem
	armadilha = origem

	altura_final = global_position.y
	altura_inicial = altura_final + ALTURA_EMERSAO
	global_position.y = altura_inicial

	z_index = -1


func _physics_process(delta: float) -> void:
	if encontro_concluido:
		return

	if not is_instance_valid(mago):
		queue_free()
		return

	if mago.get("em_falha") == true:
		encontro_concluido = true
		queue_free()
		return

	global_position.x -= VELOCIDADE_HORDA * delta

	tempo_emersao += delta

	var progresso: float = clampf(
		tempo_emersao / DURACAO_EMERSAO,
		0.0,
		1.0
	)

	var suavizado = progresso * progresso * (3.0 - 2.0 * progresso)

	global_position.y = lerpf(
		altura_inicial,
		altura_final,
		suavizado
	)

	if progresso >= 0.5:
		z_index = 1

	if mago.global_position.x > global_position.x + 125.0:
		_encerrar_encontro()


func invocar_parede() -> void:
	if encontro_concluido or not is_instance_valid(mago):
		return

	if parede_invocada:
		print("A parede já foi invocada!")
		return

	parede_invocada = true

	parede_instanciada = PAREDE_CENA.instantiate()
	parede_instanciada.position = Vector2(-42, 0)
	add_child(parede_instanciada)

	print("Parede invocada! Prepare-se para saltar!")


func _encerrar_encontro() -> void:
	if encontro_concluido:
		return

	encontro_concluido = true

	if not parede_invocada:
		print("Você precisa invocar a parede para superar a horda!")

		if is_instance_valid(mago):
			mago.call("falhar")
	else:
		print("Horda ultrapassada!")

		if is_instance_valid(armadilha):
			armadilha.call("finalizar_encontro", mago)

	queue_free()
