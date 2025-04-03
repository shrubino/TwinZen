extends AnimatedSprite2D

@onready var move_away = false
@onready var move_speed = 100

func _process(delta):
	if move_away == true:
		position.y += move_speed * delta
	if position.y >= 200:
		queue_free()

func _on_animation_looped() -> void:
	move_away = true
