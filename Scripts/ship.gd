extends Node2D  # or whatever your player extends

var center_position: float
var left_position: float
var right_position: float
var target_position: float
var lerp_speed: float = 5.0
var return_delay: float = 0.4
var timer: float = 0.0
var is_moving: bool = false

@onready var hull_bar = $"../HullContainer/Hull Bar"

func _ready() -> void:
	center_position = global_position.x
	left_position = center_position - 50.0
	right_position = center_position + 50.0
	# Set initial target to center
	target_position = center_position



func _physics_process(delta: float) -> void:
	var x_input = Input.get_axis("ship_left", "ship_right")
	
	if !is_moving:
		if x_input < 0:  # Left pressed
			target_position = left_position
			is_moving = true
			timer = 0.0
		elif x_input > 0:  # Right pressed
			target_position = right_position
			is_moving = true
			timer = 0.0
	
	if is_moving:
		timer += delta
		if timer >= return_delay:
			target_position = center_position
			if abs(global_position.x - center_position) < 5.0:
				is_moving = false
	
	global_position.x = lerp(global_position.x, target_position, lerp_speed * delta)


func _on_area_2d_area_entered(area: Area2D) -> void:
	hull_bar.value -= 10
