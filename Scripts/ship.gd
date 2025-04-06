extends Node2D  


@onready var center_position: float
@onready var left_position: float
@onready var right_position: float
@onready var target_position: float
@onready var forward_position: float
@onready var backward_position: float
@onready var lerp_speed: float = 6.0
@onready var return_delay: float = 0.4
@onready var timer: float = 0.0
@onready var is_moving: bool = false

@onready var hull_bar = $"../HullContainer/Hull Bar"
@onready var force_field = $"Force Field"
@onready var force_field_active = false
@onready var dodge_sound = $"Dodge Sound"
@onready var collision_sound = $"Collision Sound"
@onready var dodge_file_120 = preload("res://Resources/Audio/ship_dodge 120.wav")
@onready var dodge_file_130 = preload("res://Resources/Audio/ship_dodge_130.wav")
@onready var dodge_file_140 = preload("res://Resources/Audio/ship_dodge_140.wav")

@onready var progress_bar = $"../Progress bar"

func _ready() -> void:
	center_position = global_position.x
	left_position = center_position - 50.0
	right_position = center_position + 50.0
	# Set initial target to center
	target_position = center_position


func _physics_process(delta: float) -> void:
	var x_input = Input.get_axis("ship_left", "ship_right")
	if abs(x_input) > 0:
		dodge_sound.play()
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
	if force_field_active != true:
		collision_sound.play()
		hull_bar.value -= 10
		progress_bar.mini_ship.position.x += 1
		if hull_bar.value <= 0:
			its_all_over()
	

func enable_force_field(time):
	force_field_active = true
	force_field.visible = true
	await get_tree().create_timer(time).timeout
	force_field_active = false
	force_field.visible = false

func its_all_over():
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/failure_screen.tscn")
	
func check_bpm():
	if Globals.bpm == 130:
		dodge_sound.stream = dodge_file_130
	if Globals.bpm == 140:
		dodge_sound.stream = dodge_file_140
