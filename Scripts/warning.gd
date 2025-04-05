extends Sprite2D

@onready var linger_time = 0.4

func _ready():
	await get_tree().create_timer(linger_time).timeout
	queue_free()
