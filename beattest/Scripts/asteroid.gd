extends AnimatedSprite2D

@export var speed = 120
@onready var collider = $Area2D
func _ready():
	set_as_top_level(true)
	flip_h = randi_range(0,1)
	flip_v = randi_range(0,1)
 
func _process(delta):
	position.y += speed * delta
	if position.y >= 200:
		queue_free()


func _on_area_2d_area_entered(area: Area2D) -> void:
	print("you got hit!")
