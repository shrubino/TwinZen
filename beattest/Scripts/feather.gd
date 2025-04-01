extends AnimatedSprite2D

@onready var breath_speed = 2
@onready var velocity = Vector2(0,0)
@onready var gravity = 0.25

func _process(delta):
	if Input.is_action_pressed("monk_w"):
		velocity.y -= breath_speed * delta 
	velocity.y += gravity * delta
	position += velocity
