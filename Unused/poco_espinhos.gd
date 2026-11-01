
extends Area2D

enum Estado {
	DISPONIVEL,
	CORDA_ATIVA,
	USADO
}

var estado_atual = Estado.DISPONIVEL
var tentativa_consumida = false
var mago_pendurado: CharacterBody2D = null
var mago_detectado: CharacterBody2D = null

@onready var detector: Area2D = $Detector
@onready var ponto_corda: Marker2D = $PontoCorda
@onready var corda_visual: Line2D = $CordaVisual


func _ready() -> void:
	detector.body_entered.connect(_ao_entrar_detector)
	detector.body_exited.connect(_ao_sair_detector)
	body_exited.connect(_ao_sair_do_poco)

	corda_visual.visible = false
	corda_visual.width = 5.0
	corda_visual.default_color = Color(0.0, 1.0, 1.0, 1.0)


func _process(_delta: float) -> void:
	if is_instance_valid(mago_pendurado):
		corda_visual.clear_points()
		corda_visual.add_point(to_local(ponto_corda.global_position))
		corda_visual.add_point(
			to_local(mago_pendurado.global_position + Vector2(0, -12))
		)


func _ao_entrar_detector(body: Node2D) -> void:
	if body is CharacterBody2D:
		mago_detectado = body
		body.set("poco_atual", self)
		print("Poço com espinhos detectado!")


func _ao_sair_detector(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body.get("poco_atual") == self:
			body.set("poco_atual", null)

		if mago_detectado == body:
			mago_detectado = null


func invocar_ponte() -> void:
	if tentativa_consumida:
		print("A tentativa de invocação já foi utilizada.")
		return

	print("A ponte não funciona sobre os espinhos. Tente a corda.")


func invocar_corda(mago: CharacterBody2D) -> void:
	if tentativa_consumida:
		print("A tentativa já foi utilizada!")
		return

	if estado_atual != Estado.DISPONIVEL:
		return

	tentativa_consumida = true
	estado_atual = Estado.CORDA_ATIVA
	mago_pendurado = mago

	var altura_segura = ponto_corda.global_position.y + 90.0
	mago.call("iniciar_pendurado", altura_segura, self)

	corda_visual.visible = true
	print("Corda invocada! Atravesse os espinhos!")


func invocar_errado() -> void:
	print("Essa magia não resolve o obstáculo.")
	
func _ao_sair_do_poco(body: Node2D) -> void:
	if body != mago_pendurado:
		return

	if is_instance_valid(mago_pendurado):
		mago_pendurado.call("liberar_corda")

	mago_pendurado = null
	corda_visual.visible = false
	estado_atual = Estado.USADO
	print("Travessia concluída!")
