extends CanvasLayer

@onready var death_label: Label = $Label
@onready var timer_label: Label = $TimerLabel
@onready var game_timer_node: Timer = $GameTimer

func _ready() -> void:
	game_timer_node.start()
	update_timer_label()

func _process(_delta: float) -> void:
	death_label.text = "Muertes: %d" % Global.death_count

func update_timer_label() -> void:
	var minutes = Global.game_timer / 60
	var seconds = Global.game_timer % 60
	timer_label.text = "%02d:%02d" % [minutes, seconds]

func _on_game_timer_timeout() -> void:
	if Global.game_timer > 0:
		Global.game_timer -= 1
		update_timer_label()
	else:
		game_timer_node.stop()
		get_tree().change_scene_to_file("res://Scenes/perdiste.tscn")
