extends Node

@export var astroid_scene: PackedScene
@export var level: int

@onready var restart_button: Button = $WinLoseUI/Container/RestartButton
@onready var next_level_button: Button = $WinLoseUI/Container/NextLevelButton
@onready var win_lose_ui: CenterContainer = $WinLoseUI
@onready var win_lose_label: Label = $WinLoseUI/Container/WinLoseLabel
@onready var music_audio: AudioStreamPlayer = $Music
@onready var player_explosion_audio: AudioStreamPlayer = $PlayerExplosion
@onready var earth_death_audio: AudioStreamPlayer = $EarthDeath
@onready var player_off_screen_audio: AudioStreamPlayer = $PlayerOffScreen

func _ready() -> void:
	toggle_sound_effects(true)

func toggle_sound_effects(mute: bool):
	var bus_booster = AudioServer.get_bus_index("Boosters")
	var bus_explosions = AudioServer.get_bus_index("Explosions")
	var bus_voices = AudioServer.get_bus_index("Voices")
	AudioServer.set_bus_mute(bus_booster, mute)
	AudioServer.set_bus_mute(bus_explosions, mute)
	AudioServer.set_bus_mute(bus_voices, mute)

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
		Globals.toggle_sound_effects(false)
	if Input.is_key_pressed(KEY_Z):
		get_tree().change_scene_to_file("res://Main3D.tscn")
		Globals.toggle_sound_effects(false)
		# REMEMBER TO REMOVE BEFORE 16:00!!!
	
	if !music_audio.playing:
		music_audio.play()
		
func next():
	level += 1
	print(level)
	get_tree().change_scene_to_file('res://Levels/level-' + str(level) + '.tscn')
	destroyAstroids()

func off_screen():
	player_off_screen_audio.play()
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
	earth_death_audio.play()
	win_lose_ui.visible = true
	restart_button.visible = false
	next_level_button.visible = true
	var win_messages = [
		"You killed 8.2 billion people!",
		"Everyone died!",
		"You got down to Earth!",
		"No Earth, no problems",
		"Global warming solved!",
		"Woho!",
		"The Tesla has returned home",
		"You did it!",
		"Fuck yes",
		"**** yes",
		"Hot damn",
		":')",
	]
	win_lose_label.text = win_messages.pick_random()

func final():
	win_lose_ui.visible = true
	restart_button.visible = false
	next_level_button.visible = false
	win_lose_label.text = "Congratulations! You bastard!"

func reset():
	destroyAstroids()
	win_lose_ui.visible = false

func destroyAstroids():
	var astroids = get_tree().get_nodes_in_group("astroids")
	for astroid in astroids:
		astroid.queue_free()

func start_astroids():
	$AstroidTimer.start()
	
func stop_astroids():
	$AstroidTimer.stop()
	
func astroid_spawn_time(time:float) -> void:
	$AstroidTimer.wait_time = time
