extends Node

@export var astroid_scene: PackedScene

@onready var restart_button: Button = $WinLoseUI/Container/RestartButton
@onready var next_level_button: Button = $WinLoseUI/Container/NextLevelButton
@onready var win_lose_ui: CenterContainer = $WinLoseUI
@onready var win_lose_label: Label = $WinLoseUI/Container/WinLoseLabel
@onready var music_audio: AudioStreamPlayer = $Music
@onready var player_explosion_audio: AudioStreamPlayer = $PlayerExplosion

func _on_astroid_timer_timeout() -> void:
	var scene = get_tree().current_scene
	if scene != null:
		var player = scene.get_node("Player")
		if player != null:	
			var astroid = astroid_scene.instantiate()
			var astroid_spawn_location = get_node("SpawnPath/SpawnLocation")
			astroid_spawn_location.progress_ratio = randf()
			astroid.initialize(astroid_spawn_location.position, player.position)
			add_child(astroid)


func _process(delta):
	if Input.is_key_pressed(KEY_R):
		get_tree().reload_current_scene()
		reset()
	if Input.is_key_pressed(KEY_Z):
		get_tree().change_scene_to_file("res://Main3D.tscn")
		# REMEMBER TO REMOVE BEFORE 16:00!!!
	
	if !music_audio.playing:
		music_audio.play()

func lost():
	win_lose_ui.visible = true
	restart_button.visible = true
	next_level_button.visible = false
	win_lose_label.text = "Drifted off into deep space..."

func lose():
	player_explosion_audio.play()
	win_lose_ui.visible = true
	restart_button.visible = true
	next_level_button.visible = false
	win_lose_label.text = "You died"

func win():
	player_explosion_audio.play()
	win_lose_ui.visible = true
	restart_button.visible = false
	next_level_button.visible = true
	win_lose_label.text = "You killed 8.2 billion people!"

func reset():
	win_lose_ui.visible = false
