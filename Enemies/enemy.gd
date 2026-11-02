class_name Enemy
extends CharacterBody2D

@export var grav: float = 980
@export var speed: float = 80
@onready var fallcheck: RayCast2D = $RayCast2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var flip: bool = true
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	if (flip):
		sprite.flip_h = true
		if (fallcheck):
			fallcheck.target_position.x = abs(fallcheck.target_position.x)*-1
		else:
			print("AJEITA O RAYCAST DO INIMIGO")
	else:
		sprite.flip_h = false
		if (fallcheck):
			fallcheck.target_position.x = abs(fallcheck.target_position.x)
		else:
			print("AJEITA O RAYCAST DO INIMIGO")

func _physics_process(delta: float) -> void:
	handle_movement(delta)

func dont_fall() -> void:
	if (fallcheck):
		if (is_on_floor()):
			if (!fallcheck.is_colliding()):
				turn()
	if (is_on_wall()):
		turn()
func turn() -> void:
	fallcheck.target_position.x *= -1
	match flip:
		true:
			flip = false
			sprite.flip_h = false
		false:
			flip = true
			sprite.flip_h = true

#eu quando eu roubo meu próprio código
func handle_movement(delta:float) -> void:
	if(is_on_floor()):
		match flip:
			true: velocity.x = -speed
			false: velocity.x = speed
	else:
		velocity.x = 0
	if (!is_on_floor()):
		velocity.y += grav*delta
	var colidiu := move_and_slide()
	update_animation()
	if (colidiu):
		var col = get_last_slide_collision()
		var collider = col.get_collider()
		if (collider is Player):
			collider.falhar()
			attack(collider)

#preso numa parede ele continua tentando andar, então olha a velocidade real
func update_animation() -> void:
	if (abs(get_real_velocity().x) < 1):
		sprite.play("idle")
	else:
		sprite.play("walk")

func attack(target: Node2D) -> void:
	set_physics_process(false)
	sprite.flip_h = target.global_position.x < global_position.x
	sprite.play("attack")
