extends CharacterBody2D

const SPEED := 200.0
const JUMP_FORCE := 350.0
const GRAVITY := 900.0

const COYOTE_TIME := 0.12
var coyote_timer := 0.0

@onready var anim := $Sprite2D/AnimatedSprite2D

func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta

	var direction := Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	velocity.x = direction * SPEED

	if direction == 0:
		anim.play("idle")
	else:
		anim.play("run")
		anim.flip_h = direction < 0

	if is_on_floor():
		coyote_timer = COYOTE_TIME
	else:
		coyote_timer -= delta

	if Input.is_action_just_pressed("move_jump") and coyote_timer > 0:
		velocity.y = -JUMP_FORCE
		coyote_timer = 0

	move_and_slide()

func die():
	anim.play("die")
	await anim.animation_finished
	get_tree().reload_current_scene()
