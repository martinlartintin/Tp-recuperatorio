extends CharacterBody2D

const SPEED := 80.0
const GRAVITY := 900.0

var direction := -1

@onready var ray_down := $RayCast2D
@onready var sprite := $Sprite2D
@onready var damage_area := $DamageArea

func _ready():
	pass

func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	velocity.x = direction * SPEED

	if not ray_down.is_colliding():
		_turn()

	if is_on_wall():
		_turn()

	move_and_slide()

	sprite.flip_h = direction < 0

func _turn():
	direction *= -1
	ray_down.position.x *= -1

func _on_damage_area_body_entered(body: Node) -> void:
	var root := body

	while root and not root.is_in_group("Player"):
		root = root.get_parent()

	if root and root.is_in_group("Player"):
		root.die()
