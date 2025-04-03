extends AnimatedSprite2D

@onready var breath_speed = 0.2
@onready var is_at_peace = true
@onready var velocity = Vector2(0,0)
@onready var gravity = 0.05
@onready var main_game = get_parent()
@onready var bubble2 = $"../Bubble2"
@onready var bubble1 = $"../Bubble1"

@onready var monk = $"../Monk"
@onready var peace_bar = $"../PeacebarContainer/Peace Bar"
@onready var peace_increase_rate = 1
@onready var peace_decrease_rate = 2

@export_category("Metronome stuff")
@onready var tutorial_timer = 9
@onready var tutorial_ended = false
@export var time_for_asteroids = 0.5
@export var measures = [4]
@onready var space_metronome = $"../SpaceMetronome"
@onready var asteroid_bloop = $"../AsteroidBloop"

@export_category("Sun and Moon ")
@onready var sun = $"../Sun and Moon"
@onready var sun_positions = [Vector2(0, 82.0), Vector2(32.0, 52.0),Vector2(72.0, 33.0), Vector2(114, 58), Vector2(144, 82)]
@onready var sun_index = 0
@onready var is_moon = false
@onready var sun_sprite = preload("res://Resources/Sprites/sun.png")
@onready var moon_sprite = preload("res://Resources/Sprites/moon.png")

@export_category("Wind stuff")
@export var wind = false
@export var wind_direction = randi_range(-1,1)
@export var wind_speed = 0.03
@onready var east_wind = $"../MonkWindEast"
@onready var west_wind = $"../MonkWindWest"

func _ready():
	sun.position = sun_positions[sun_index]

	await get_tree().create_timer(tutorial_timer).timeout
	tutorial_ended = true
	start_timer()
	start_peace_timer()
	
func _process(delta):
	if tutorial_ended == true:
		if Input.is_action_pressed("monk_w"):
			velocity.y -= breath_speed * delta 
		if Input.is_action_pressed("monk_s"):
			velocity.y += breath_speed * delta 
		if Input.is_action_pressed("monk_a"):
			velocity.x -= breath_speed * delta 
		if Input.is_action_pressed("monk_d"):
			velocity.x += breath_speed * delta 
		velocity.y += gravity * delta
		position += velocity
		bubble2.position += velocity/2
		bubble1.position += velocity/3
		handle_clamps()
		handle_wind(delta)
	
func handle_wind(delta):
	if wind == true:
		velocity.x += wind_speed * wind_direction * delta
		if wind_direction == 1:
			east_wind.visible = true
			west_wind.visible = false
		if wind_direction == -1:
			west_wind.visible = true
			east_wind.visible = false

func handle_clamps():
	velocity.y = clamp(velocity.y, -0.1, 0.1)
	velocity.x = clamp(velocity.x, -0.1, 0.1)
	position.y = clamp(position.y, 0, 110)
	position.x = clamp(position.x, 0, 120)
	bubble2.position.y = clamp(bubble2.position.y, 0, 110)
	bubble2.position.x = clamp(bubble2.position.x, 0, 120)
	bubble1.position.y = clamp(bubble1.position.y, 0, 110)
	bubble1.position.x = clamp(bubble1.position.x, 0, 120)
	
func start_peace_timer():
	if is_at_peace:
		await get_tree().create_timer(peace_increase_rate).timeout
		peace_bar.value += 1
		Globals.score += 10
	else:
		await get_tree().create_timer(peace_decrease_rate).timeout
		peace_bar.value -= 1
	start_peace_timer()
	
func start_timer():
	for x in measures.size():
		for y in measures[x]:
			await get_tree().create_timer(time_for_asteroids).timeout
		await get_tree().create_timer(time_for_asteroids).timeout
		advance_sun()
		#asteroid_bloop.play()
	start_timer()

func advance_sun():
	sun.position = sun_positions[sun_index]
	if sun_index == sun_positions.size() - 1 and not is_moon:
		is_moon = true
		wind = true
		wind_direction = randi_range(-1,1)
		sun.texture = moon_sprite
	elif sun_index == 0 and is_moon:
		is_moon = false
		wind_direction = randi_range(-1,1)
		sun.texture = sun_sprite
	if is_moon:
		sun_index -= 1
	else:
		sun_index += 1
		
	sun_index = clamp(sun_index, 0, sun_positions.size() - 1)

func _on_animation_looped() -> void:
	flip_h = randi_range(0,1)

func _on_area_2d_area_entered(area: Area2D) -> void:
	is_at_peace = true
	monk.play("default")

func _on_area_2d_area_exited(area: Area2D) -> void:
	is_at_peace = false
	monk.play("disturbed")
