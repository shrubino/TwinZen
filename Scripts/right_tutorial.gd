extends AnimatedSprite2D

@onready var move_away = false
@onready var move_speed = 100
@onready var tutorial_time = 18

@onready var white_sprite = preload("res://Resources/Sprites/arrows_white2.png")
@onready var red_sprite = preload("res://Resources/Sprites/arrows_red.png")

@onready var W = $W
@onready var A = $A
@onready var D = $D
@onready var S = $S


func _ready():
	await get_tree().create_timer(tutorial_time).timeout
	A.visible = true
	D.visible = true
	play()

func _process(delta):
	handle_sprite_colors()

	if move_away == true:
		position.y -= move_speed * delta
	if position.y >= 200:
		queue_free()


func _on_animation_looped() -> void:
	move_away = true


func handle_sprite_colors():
	if Input.is_action_pressed("ship_up"):
		W.texture = white_sprite
	else:
		W.texture = red_sprite
	if Input.is_action_pressed("ship_down"):
		S.texture = white_sprite
	else:
		S.texture = red_sprite
	if Input.is_action_pressed("ship_left"):
		A.texture = white_sprite
	else:
		A.texture = red_sprite
	if Input.is_action_pressed("ship_right"):
		D.texture = white_sprite
	else:
		D.texture = red_sprite
