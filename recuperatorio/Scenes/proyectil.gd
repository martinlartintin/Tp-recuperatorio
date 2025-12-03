extends Area2D

@export var speed := 200

func _physics_process(delta):
	position.y -= speed * delta

	if position.y < -1000:
		queue_free()

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.die()
		queue_free()
