extends AnimatedSprite2D

@onready var move_away = false
@onready var move_speed = 100
@onready var feather = $Feather
@onready var feather_velocity = Vector2(0,0)
@onready var gravity = 0.05
@onready var breath_speed = 0.2

@export_category("WASD Controls")
@onready var white_sprite = preload("res://Resources/Sprites/WASD_white.png")
@onready var red_sprite = preload("res://Resources/Sprites/WASD_red.png")
@onready var W = $W
@onready var A = $A
@onready var D = $D
@onready var S = $S




func _process(delta):
	if move_away == true:
		position.y += move_speed * delta
	if position.y >= 200:
		queue_free()
	if Input.is_action_pressed("monk_w"):
		feather_velocity.y -= breath_speed * delta 
	if Input.is_action_pressed("monk_s"):
		feather_velocity.y += breath_speed * delta 
	if Input.is_action_pressed("monk_a"):
		feather_velocity.x -= breath_speed * delta 
	if Input.is_action_pressed("monk_d"):
		feather_velocity.x += breath_speed * delta 
	handle_sprite_colors()
	feather_velocity.y += gravity * delta
	feather.position += feather_velocity
	handle_clamps()
	
func handle_clamps():
	feather_velocity.y = clamp(feather_velocity.y, -0.1, 0.1)
	feather_velocity.x = clamp(feather_velocity.x, -0.1, 0.1)
	feather.position.y = clamp(feather.position.y, -60, 110)
	feather.position.x = clamp(feather.position.x, -100, 100)

func handle_sprite_colors():
	if Input.is_action_pressed("monk_w"):
		W.texture = red_sprite
	else:
		W.texture = white_sprite
	if Input.is_action_pressed("monk_s"):
		S.texture = red_sprite
	else:
		S.texture = white_sprite
	if Input.is_action_pressed("monk_a"):
		A.texture = red_sprite
	else:
		A.texture = white_sprite
	if Input.is_action_pressed("monk_d"):
		D.texture = red_sprite
	else:
		D.texture = white_sprite

func _on_animation_looped() -> void:
	move_away = true
