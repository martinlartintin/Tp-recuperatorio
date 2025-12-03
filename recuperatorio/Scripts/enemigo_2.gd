extends CharacterBody2D

const CHASE_SPEED := 100.0
const GRAVITY := 900.0

var player: Node = null
var chasing := false

@onready var sprite := $Sprite2D/AnimatedSprite2D
@onready var damage_area := $DamageArea
@onready var detection_area := $DetectionArea

func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta

	if chasing and player:
		var dir_to_player = sign(player.global_position.x - global_position.x)
		velocity.x = dir_to_player * CHASE_SPEED

		sprite.play("run")
		sprite.flip_h = dir_to_player == 1

	else:
		velocity.x = 0
		sprite.play("idle")

	move_and_slide()

func _on_detection_area_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		player = body
		chasing = true

func _on_detection_area_body_exited(body: Node) -> void:
	if body == player:
		player = null
		chasing = false

func _on_damage_area_body_entered(body: Node2D) -> void:
	var root := body

	while root and not root.is_in_group("Player"):
		root = root.get_parent()

	if root and root.is_in_group("Player"):
		root.die()
