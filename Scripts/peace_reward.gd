extends Sprite2D


@onready var A = $A
@onready var D = $D
@onready var white_sprite = preload("res://Resources/Sprites/WASD_white.png")
@onready var red_sprite = preload("res://Resources/Sprites/WASD_red.png")
@onready var ship = $"../Ship"
@onready var is_active = false
@onready var time_to_disappear = 0.25

@export_category("Peace Bonuses")
@export var healing_boost = 25
@export var force_field_time = 8
@onready var peace_bar = $"../PeacebarContainer/Peace Bar"


func _process(delta):
	if is_active == true:
		if Input.is_action_pressed("monk_a"):
			A.texture = red_sprite
			trigger_A()
		else:
			A.texture = white_sprite
		if Input.is_action_pressed("monk_d"):
			D.texture = red_sprite
			trigger_D()
		else:
			D.texture = white_sprite
	if is_active == false:
		await get_tree().create_timer(time_to_disappear).timeout
		visible = false



func trigger_A():
	ship.hull_bar.value += healing_boost
	is_active = false
	peace_bar.value -= 50
	
	
func trigger_D():
	ship.enable_force_field(force_field_time)
	is_active = false
	peace_bar.value -= 50
