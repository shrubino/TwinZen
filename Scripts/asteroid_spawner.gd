extends Node2D

@onready var asteroid = preload("res://Scenes/asteroid.tscn")
@onready var warning = preload("res://Scenes/warning.tscn")
@onready var space_metronome = $"../SpaceMetronome"
@onready var asteroid_bloop = $"../AsteroidBloop"
@export var time_for_asteroids = 0.4
@export var time_for_asteroids_130bpm = 0.4

@export var measures = [1, 2]
@export var positioning = 45

@onready var tutorial_timer = 30
@onready var tutorial_ended = false

@onready var music_controller = $"../MusicController"
@onready var brass_timer = 16
@onready var bpm_130_timer = 35
@onready var bpm_140_timer = 45
@onready var ship = $"../Ship"

@onready var progress_bar = $"../Progress bar"


func _ready():
	start_timer()
	await get_tree().create_timer(tutorial_timer).timeout
	tutorial_ended = true
	music_controller.bass_cue_in = true
	await get_tree().create_timer(brass_timer).timeout
	music_controller.brass_cue_in = true
	await get_tree().create_timer(bpm_130_timer).timeout
	switch_to_130()
	await get_tree().create_timer(bpm_140_timer).timeout
	switch_to_140()

func start_timer():
	for x in measures.size():
		for y in measures[x]:
			await get_tree().create_timer(time_for_asteroids).timeout
			#space_metronome.play() #bleep
		await get_tree().create_timer(time_for_asteroids).timeout
		#asteroid_bloop.play() #bloop
		spawn_asteroid()
		if tutorial_ended == true:
			progress_bar.mini_ship.position.x -= 1
	start_timer()

func spawn_asteroid():
	if !tutorial_ended:
		return
	else:
		var asteroid_num = randi_range(1,2) if !Globals.bpm == 140 else 2
		var first_offset = 0
		var first_asteroid = asteroid.instantiate()
		first_asteroid.position = self.position
		first_offset = randi_range(-1, 1)
		
		var force_middle_column = randi_range(1,2) <= 1
		if force_middle_column:
			first_offset = 0
		first_asteroid.position.x += (positioning * first_offset)
		get_parent().add_child(first_asteroid)
		
		if asteroid_num == 2:
			var second_asteroid = asteroid.instantiate()
			second_asteroid.position = self.position
			var second_offset
			if first_offset == 0:
				second_offset = [-1, 1].pick_random()
			else:
				var unoccupied_offsets = [-1, 0, 1]
				unoccupied_offsets.erase(first_offset)
				second_offset = unoccupied_offsets.pick_random()
				
			second_asteroid.position.x += (positioning * second_offset)
			get_parent().add_child(second_asteroid)

func switch_to_130():
	Globals.bpm = 130
	ship.check_bpm()
	music_controller.switch_to_130()
	time_for_asteroids = 0.368

func switch_to_140():
	Globals.bpm = 140
	ship.check_bpm()
	music_controller.switch_to_140()
	time_for_asteroids = 0.343
