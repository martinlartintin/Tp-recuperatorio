extends Area2D

@onready var sprite := $Sprite2D

func _ready():
	visible = Global.cofre_abierto

func _on_body_entered(body: Node) -> void:
	var player := body
	if not player.is_in_group("Player"):
		if player.get_parent() and player.get_parent().is_in_group("Player"):
			player = player.get_parent()
		else:
			return

	get_tree().change_scene_to_file("res://Scenes/Ganaste.tscn")
