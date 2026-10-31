
extends CharacterBody2D

const VELOCIDADE = 220.0
const GRAVIDADE = 980.0
const GRAVIDADE_SALTO = 3600.0
const VELOCIDADE_PULO = -1100.0
const LIMITE_QUEDA = 1000.0
const TEMPO_ATE_REINICIAR = 0.8

var poco_atual: Area2D = null
var pendurado_na_corda = false
var altura_pendurado: float = 0.0
var suporte_corda: Area2D = null
var em_falha = false
var em_salto = false


func _physics_process(delta: float) -> void:
	if em_falha:
		velocity.x = 0.0
		velocity.y += GRAVIDADE * delta
		move_and_slide()
		return
	
	
	if Input.is_action_just_pressed("invocar_parede"):
		if is_instance_valid(poco_atual):
			if poco_atual.has_method("invocar_parede"):
				poco_atual.call("invocar_parede")
			else:
				invocar_errado()
		else:
			invocar_errado()


	velocity.x = VELOCIDADE

	if pendurado_na_corda:
		velocity.y = 0.0
		global_position.y = altura_pendurado
		em_salto = false
	elif is_on_floor():
		velocity.y = 0.0
		em_salto = false
	else:
		if em_salto:
			velocity.y += GRAVIDADE_SALTO * delta
		else:
			velocity.y += GRAVIDADE * delta

	if Input.is_action_just_pressed("pular"):
		if is_on_floor() and not pendurado_na_corda:
			velocity.y = VELOCIDADE_PULO
			em_salto = true

	if Input.is_action_just_pressed("invocar_ponte"):
		if is_instance_valid(poco_atual):
			if poco_atual.has_method("invocar_ponte"):
				poco_atual.call("invocar_ponte")
			else:
				invocar_errado()
		else:
			invocar_errado()

	if Input.is_action_just_pressed("invocar_corda"):
		if is_instance_valid(poco_atual):
			if poco_atual.has_method("invocar_corda"):
				poco_atual.call("invocar_corda", self)
			else:
				invocar_errado()
		else:
			invocar_errado()

	move_and_slide()

	if global_position.y > LIMITE_QUEDA:
		falhar()


func iniciar_pendurado(altura: float, obstaculo: Area2D) -> void:
	pendurado_na_corda = true
	altura_pendurado = altura
	suporte_corda = obstaculo
	velocity.y = 0.0
	em_salto = false
	global_position.y = altura_pendurado


func liberar_corda() -> void:
	pendurado_na_corda = false
	suporte_corda = null
	velocity.y = 0.0


func invocar_errado() -> void:
	print("Nenhuma magia válida neste local.")


func falhar() -> void:
	if em_falha:
		return

	em_falha = true
	velocity.x = 0.0

	print("Falha! A fase será reiniciada.")

	await get_tree().create_timer(TEMPO_ATE_REINICIAR).timeout

	get_tree().reload_current_scene()
