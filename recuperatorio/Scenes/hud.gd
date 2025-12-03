extends CanvasLayer

@onready var label := $Label

func _process(delta):
	label.text = "Muertes: %s" % Global.death_count
