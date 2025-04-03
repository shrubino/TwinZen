extends Node2D

@onready var asteroid = preload("res://Scenes/asteroid.tscn")
@onready var space_metronome = $"../SpaceMetronome"
@onready var asteroid_bloop = $"../AsteroidBloop"
@export var time_for_asteroids = 0.5
@export var measures = [1]
@export var positioning = 45

func _ready():
	start_timer()

func start_timer():
	for x in measures.size():
		for y in measures[x]:
			await get_tree().create_timer(time_for_asteroids).timeout
			space_metronome.play() #bleep
		await get_tree().create_timer(time_for_asteroids).timeout
		asteroid_bloop.play() #bloop
		spawn_asteroid()
	start_timer()

func spawn_asteroid(): #This is a Claude output, but I can rewrite it if you want to avoid needing any LLM disclosures!
	var number_of_asteroids = randi_range(1, 2)
	
	# If no asteroids to spawn, just return
	if number_of_asteroids == 0:
		return
	
	# For tracking offsets
	var first_offset = 0
	
	# Spawn first asteroid
	if number_of_asteroids >= 1:
		var first_asteroid = asteroid.instantiate()
		first_asteroid.position = self.position
		first_offset = randi_range(-1, 1)
		first_asteroid.position.x += (positioning * first_offset)
		get_parent().add_child(first_asteroid)
	
	# Spawn second asteroid with different x position
	if number_of_asteroids == 2:
		var second_asteroid = asteroid.instantiate()
		second_asteroid.position = self.position
		
		# Ensure second offset is different from the first
		var second_offset
		if first_offset == 0:
			# If first is centered, randomly go left or right
			second_offset = [-1, 1].pick_random()
		else:
			# If first is left/right, either go opposite or center
			var possible_offsets = [-1, 0, 1]
			possible_offsets.erase(first_offset)
			second_offset = possible_offsets.pick_random()
		
		second_asteroid.position.x += (positioning * second_offset)
		get_parent().add_child(second_asteroid)
