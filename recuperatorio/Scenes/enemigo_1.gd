extends CharacterBody2D

const SPEED := 80.0
const GRAVITY := 900.0

var direction := -1

@onready var ray_down := $RayCast2D
@onready var sprite := $Sprite2D
@onready var damage_area := $DamageArea

func _ready():
	damage_area.body_entered.connect(_on_damage_area_body_entered)

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
	var player := body
	if not player.is_in_group("Player") and player.get_parent():
		player = player.get_parent()

	if player.is_in_group("Player"):
		player.die()
