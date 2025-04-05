extends AnimatedSprite2D

@onready var button = $Button


func _on_button_button_down() -> void:
	get_tree().call_deferred("change_scene_to_file","res://Scenes/main_game.tscn" )


func _on_animation_finished() -> void:
	button.visible = true
