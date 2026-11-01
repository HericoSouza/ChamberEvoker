extends Area2D


#isso é ineficiente e horrível mas esse jogo é pequeno então não vai importar
#(ele está falando de usar o get_nodes_in_group toda vez que algo entra ou sai
#da área)
#(eu queria deixar poder botar mais de um objetivo)
func _on_body_entered(body: Node2D) -> void:
	var objectives: Array[Node] = get_tree().get_nodes_in_group("objective")
	for i in objectives:
		if i is Objective:
			i.button_pressed()


func _on_body_exited(body: Node2D) -> void:
	var objectives: Array[Node] = get_tree().get_nodes_in_group("objective")
	for i in objectives:
		if i is Objective:
			i.button_unpressed()
