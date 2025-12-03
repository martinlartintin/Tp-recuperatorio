extends CharacterBody2D

const SPEED: float = 200.0
const JUMP_FORCE: float = 350.0
const GRAVITY: float = 900.0
const COYOTE_TIME: float = 0.12

var coyote_timer: float = 0.0
var is_dead: bool = false
var facing: int = 1  

@onready var anim: AnimatedSprite2D = $Sprite2D/AnimatedSprite2D
@onready var sprite: AnimatedSprite2D = $Sprite2D/AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if is_dead:
		return

	var input_dir: float = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var move_dir: int = sign(input_dir)

	var current_speed: float = SPEED
	var current_jump_force: float = JUMP_FORCE
	if Global.cofre_abierto:
		current_speed = SPEED * 1.5
		current_jump_force = JUMP_FORCE * 1.5
	velocity.x = move_dir * current_speed

	if move_dir != 0:
		facing = move_dir
		sprite.flip_h = facing == -1

	velocity.y += GRAVITY * delta

	if is_on_floor():
		coyote_timer = COYOTE_TIME
	else:
		coyote_timer -= delta

	if Input.is_action_just_pressed("move_jump") and coyote_timer > 0:
		velocity.y = -JUMP_FORCE
		coyote_timer = 0

	move_and_slide()

	if not is_on_floor():
		if velocity.y < 0:
			anim.play("jump")
		else:
			anim.play("fall")
	else:
		if move_dir == 0:
			anim.play("idle")
		else:
			anim.play("run")

func receive_damage(enemy_position: Vector2) -> void:
	if is_dead:
		return

	if Global.cofre_abierto:
		var enemy_dir: int = sign(enemy_position.x - global_position.x)
		if enemy_dir != facing:
			return

	Global.death_count += 1
	die()

func die() -> void:
	if is_dead:
		return
	is_dead = true
	Global.death_count += 1
	Global.cofre_abierto = false
	Global.llave_recogida = false
	anim.play("die")
	await get_tree().create_timer(0.8).timeout
	get_tree().reload_current_scene()
