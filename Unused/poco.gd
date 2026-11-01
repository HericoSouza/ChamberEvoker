
extends Area2D

enum Estado {
	ABERTO,
	COM_PONTE,
	RECARGA
}

const DURACAO_PONTE = 4.0
const TEMPO_RECARGA = 1.0

var estado_atual = Estado.ABERTO
var tentativa_consumida = false

var ponte_cena = Globals.bridge
var ponte_instanciada: StaticBody2D = null

@onready var detector: Area2D = $Detector
@onready var ponto_ponte: Marker2D = $PontoPonte


func _ready() -> void:
	detector.body_entered.connect(_ao_entrar)
	detector.body_exited.connect(_ao_sair)


func _ao_entrar(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.poco_atual = self
		print("O mago entrou na área de invocação.")


func _ao_sair(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body.poco_atual == self:
			body.poco_atual = null

		tentativa_consumida = false
		print("O mago saiu da área de invocação.")


func invocar_ponte() -> void:
	if tentativa_consumida:
		print("Tentativa já utilizada! Afaste-se e aproxime-se novamente.")
		return

	tentativa_consumida = true

	if estado_atual != Estado.ABERTO:
		print("O poço não está disponível.")
		return

	estado_atual = Estado.COM_PONTE

	var nova_ponte = ponte_cena.instantiate()
	ponte_instanciada = nova_ponte

	get_tree().current_scene.add_child(nova_ponte)

	nova_ponte.global_position = ponto_ponte.global_position
	nova_ponte.global_rotation = 0.0
	nova_ponte.global_scale = Vector2.ONE

	print("Ponte invocada! Atravesse rapidamente!")

	await get_tree().create_timer(DURACAO_PONTE).timeout

	if is_instance_valid(nova_ponte):
		nova_ponte.queue_free()

	if ponte_instanciada == nova_ponte:
		ponte_instanciada = null

	estado_atual = Estado.RECARGA
	print("A ponte desapareceu!")

	await get_tree().create_timer(TEMPO_RECARGA).timeout

	estado_atual = Estado.ABERTO
	print("O poço está disponível novamente.")


func invocar_errado() -> void:
	print("A magia foi invocada, mas não resolveu o obstáculo!")
