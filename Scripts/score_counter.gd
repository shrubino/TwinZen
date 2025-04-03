extends Label

@onready var ship = $"../../Ship"

func _process(delta):
	text = convert_to_string(Globals.score)

func convert_to_string(score):
	return("%06d" % score)
