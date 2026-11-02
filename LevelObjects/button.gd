extends Area2D

const REGION_RELEASED := Rect2(0, 0, 64, 18)
const REGION_PRESSED := Rect2(65, 0, 64, 18)

@onready var sprite: Sprite2D = $Sprite2D
var bodies_on_top: int = 0

#isso é ineficiente e horrível mas esse jogo é pequeno então não vai importar
#(ele está falando de usar o get_nodes_in_group toda vez que algo entra ou sai
#da área)
#(eu queria deixar poder botar mais de um objetivo)
func _on_body_entered(body: Node2D) -> void:
	bodies_on_top += 1
	sprite.region_rect = REGION_PRESSED
	var objectives: Array[Node] = get_tree().get_nodes_in_group("objective")
	for i in objectives:
		if i is Objective:
			i.button_pressed()


func _on_body_exited(body: Node2D) -> void:
	bodies_on_top -= 1
	if (bodies_on_top == 0):
		sprite.region_rect = REGION_RELEASED
	var objectives: Array[Node] = get_tree().get_nodes_in_group("objective")
	for i in objectives:
		if i is Objective:
			i.button_unpressed()
