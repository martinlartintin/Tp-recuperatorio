extends CanvasLayer

@onready var label := $Label
@onready var timer_label: Label = $TimerLabel
@onready var game_timer: Timer = $GameTimer

var time_remaining := 60

func _ready():
	update_timer_label()
	game_timer.start()

func _process(_delta):
	label.text = "Muertes: %s" % Global.death_count

func update_timer_label():
	var minutes = time_remaining / 60
	var seconds = time_remaining % 60
	timer_label.text = "%02d:%02d" % [minutes, seconds]

func game_over():
	get_tree().change_scene_to_file("res://Escenas/perdiste.tscn")


func _on_game_timer_timeout() -> void:
	time_remaining -= 1
	update_timer_label()

	if time_remaining <= 0:
		game_over()
