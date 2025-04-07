extends Sprite2D


@onready var monk_head = $"Monk Head"
@onready var monk_arrow = $"Monk Head/Monk Arrow"
@onready var monk_arrow_visible = true
@onready var mini_ship = $MiniShip
@onready var min_ship_arrow = true
@onready var mini_ship_arrow = $"MiniShip/Ship Arrow"

func _process(delta):
	if monk_head.position.x > 0:
		monk_head.position.x = 0
	if mini_ship.position.x < 0:
		mini_ship.position.x = 0
	if mini_ship.position.x == 0 and monk_head.position.x == 0:
		you_win_the_game()

func you_win_the_game():
	Globals.score += 1000
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/win_screen.tscn")
