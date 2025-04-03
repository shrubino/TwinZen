extends Node2D


@onready var bass120 = preload("res://Resources/Audio/bass_120bpm_no_click_at_start.wav")
@onready var bass130 = preload("res://Resources/Audio/bass_130bpm_no_click_at_start.wav")
@onready var bass140 = preload("res://Resources/Audio/bass_140bpm_no_click_at_start.wav")

@onready var drums120 = preload("res://Resources/Audio/drums_120bpm 2.wav")
@onready var drums130 = preload("res://Resources/Audio/drums_130bpm_no_crunch.wav")
@onready var drums140 = preload("res://Resources/Audio/drums_140bpm_no_crunch.wav")

@onready var brass120 = preload("res://Resources/Audio/brass_120.wav")
@onready var brass130 = preload("res://Resources/Audio/brass_130bpm 2.wav")
@onready var brass140 = preload("res://Resources/Audio/brass_140bpm.wav")

@onready var bass_player = $Bass
@onready var brass_player = $Brass
@onready var drums_player = $Drums

func _ready():
	drums_player.stream = drums120
	drums_player.play()
	

func _on_drums_finished() -> void:
	drums_player.play()
