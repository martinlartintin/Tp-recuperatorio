extends Node2D

@export var projectile_scene: PackedScene
@export var shoot_interval := 2.0
@export var projectile_speed := 200

@onready var shoot_timer := $ShootTimer
@onready var shoot_point := $ShootPoint
@onready var sprite := $Sprite2D

func _ready():
	shoot_timer.wait_time = shoot_interval
	shoot_timer.start()

func shoot_projectile():
	if projectile_scene == null:
		return

	var p = projectile_scene.instantiate()
	get_parent().add_child(p)

	p.position = shoot_point.global_position
	p.speed = projectile_speed

func _on_shoot_timer_timeout() -> void:
	shoot_projectile()
