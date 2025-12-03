extends Area2D

var is_open := false

@onready var anim := $Sprite2D/AnimatedSprite2D
@onready var label := $Label

func _ready():
	anim.play("idle")
	label.visible = false

func _on_body_entered(body: Node) -> void:
	if is_open:
		return
	
	if body.is_in_group("Player"):
		open_chest()

func open_chest():
	is_open = true
	Global.cofre_abierto = true
	anim.play("unlocked")
	label.text = "Vuelve al inicio"
	Global.game_timer = 60
	label.visible = true
	await get_tree().create_timer(3.0).timeout
	label.visible = false
