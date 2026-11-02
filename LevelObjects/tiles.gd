extends TileMapLayer

const BACKGROUND := Vector2i(3, 0)
const SOURCE := 1
#linha do atlas onde começam os tiles de borda (cada linha é uma variante)
const EDGE_ROW := 1
const EDGE_VARIANTS := 2

#escolhe o tile de borda de cada bloco olhando os vizinhos, assim as fases
#só precisam pintar onde tem chão e o musgo aparece sozinho.
#x do atlas = soma dos lados abertos: cima 1, direita 2, baixo 4, esquerda 8
func _ready() -> void:
	for cell in get_used_cells():
		if get_cell_atlas_coords(cell) == BACKGROUND:
			continue
		var open_sides := 0
		if is_open(cell + Vector2i.UP):
			open_sides += 1
		if is_open(cell + Vector2i.RIGHT):
			open_sides += 2
		if is_open(cell + Vector2i.DOWN):
			open_sides += 4
		if is_open(cell + Vector2i.LEFT):
			open_sides += 8
		if open_sides:
			var variant: int = posmod(cell.x + cell.y, EDGE_VARIANTS)
			set_cell(cell, SOURCE, Vector2i(open_sides, EDGE_ROW + variant))

#fora do mapa não conta como aberto, senão a moldura da fase ganharia musgo
func is_open(cell: Vector2i) -> bool:
	return get_cell_atlas_coords(cell) == BACKGROUND
