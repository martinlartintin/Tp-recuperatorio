extends Area2D

func _ready():
	pass

func _on_body_entered(body):
	var root: Node = body

	while root and not root.is_in_group("Player"):
		root = root.get_parent()

	if root and root.is_in_group("Player"):
		root.die()
