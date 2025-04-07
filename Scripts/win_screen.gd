extends AnimatedSprite2D
@onready var button = $Button
@onready var has_played = false

@onready var score = $Score
@onready var score_counter = $ScoreCounter

func _on_animation_finished() -> void:
	button.visible = true
	score.visible = true
	score_counter.visible = true
	
	if has_played == false:
		play("2nd")
		has_played = true



func _on_button_pressed() -> void:
	Globals.score = 0
	get_tree().call_deferred("change_scene_to_file","res://Scenes/main_game.tscn" )
