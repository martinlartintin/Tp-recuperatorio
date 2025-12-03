extends Control

@onready var death_label: Label = $VBoxContainer/Perdiste

func _ready() -> void:
	death_label.text = "Muertes: %s" % Global.death_count

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("enter"):
		get_tree().change_scene_to_file("res://Scenes/Menú.tscn")
