extends Node2D

@onready var asteroid = preload("res://Scenes/asteroid.tscn")
@onready var space_metronome = $"../SpaceMetronome"
@onready var asteroid_bloop = $"../AsteroidBloop"
@export var time_for_asteroids = 0.5
@export var measures = [1,2]
@export var positioning = 45

func _ready():
	await get_tree().create_timer(1).timeout
	start_timer()

func start_timer():
	for x in measures.size():
		for y in measures[x]:
			await get_tree().create_timer(time_for_asteroids).timeout
			space_metronome.play()
		await get_tree().create_timer(time_for_asteroids).timeout
		asteroid_bloop.play()
		spawn_asteroid()
	start_timer()

func spawn_asteroid():
	var new_asteroid = asteroid.instantiate()
	add_child(new_asteroid)
	new_asteroid.position = self.position
	var random_placer = randi_range(-1,1)
	new_asteroid.position.x += (positioning * random_placer)
