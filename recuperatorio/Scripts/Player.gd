extends CharacterBody2D

const SPEED := 200.0
const JUMP_FORCE := 400.0
const GRAVITY := 900.0

func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta

	var direction := Input.get_action_strength("move_right") - Input.get_action_strength("move_left")

	velocity.x = direction * SPEED

	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y = -JUMP_FORCE

		move_and_slide()
