extends Area2D

@onready var animation := $Sprite2D/AnimatedSprite2D

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

	animation.play("idle")

func _on_body_entered(body):
	var player = body
	if not player.is_in_group("Player"):
		if player.get_parent() and player.get_parent().is_in_group("Player"):
			player = player.get_parent()
		else:
			return

	Global.llave_recogida = true

	queue_free()
