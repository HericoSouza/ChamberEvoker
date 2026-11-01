
extends Area2D

#var HORDA_CENA = Globals.skele_horde

@onready var ponto_spawn: Marker2D = $SpawnPoint

#func _ready() -> void:
	#body_entered.connect(_ao_entrar)
#
#
#func _ao_entrar(body: Node2D) -> void:
	#if body is Player:
		#var horda_atual = HORDA_CENA.instantiate()
		#add_sibling(horda_atual)
#
		#horda_atual.global_position = ponto_spawn.global_position
#
		#print("Armadilha ativada! A horda está avançando!")
