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

@onready var bass_cue_in = false
@onready var drums_cue_in = false
@onready var brass_cue_in = false


func _ready():
	drums_player.stream = drums120
	bass_player.stream = bass120
	brass_player.stream = brass120
	drums_player.play()


func _on_drums_finished() -> void:
	drums_player.play()
	if bass_cue_in == true:
		bass_player.play()
	if brass_cue_in == true:
		brass_player.play()

func switch_to_130():
	drums_player.stream = drums130
	bass_player.stream = bass130
	brass_player.stream = brass130
	drums_player.play()
	if bass_cue_in == true:
		bass_player.play()
	if brass_cue_in == true:
		brass_player.play()

func switch_to_140():
	drums_player.stream = drums140
	bass_player.stream = bass140
	brass_player.stream = brass140
	drums_player.play()
	if bass_cue_in == true:
		bass_player.play()
	if brass_cue_in == true:
		brass_player.play()
