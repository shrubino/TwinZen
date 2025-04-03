extends AnimatedSprite2D

@export var speed = 120
@onready var collider = $Area2D
@onready var sprite_number = randi_range(1,3)
@onready var rotation_direction_constant = randi_range(-1,1)
@onready var rotation_speed = randf_range(0.005, 0.015)

func _ready():
	play(str(sprite_number))
	set_as_top_level(true)
	flip_h = randi_range(0,1)
	flip_v = randi_range(0,1)
 
func _process(delta):
	rotation += rotation_speed * rotation_direction_constant
	position.y += speed * delta
	if position.y >= 200:
		queue_free()
		Globals.score += 10


func _on_area_2d_area_entered(area: Area2D) -> void:
	pass
