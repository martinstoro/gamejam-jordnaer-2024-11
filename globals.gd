extends Node

@export var astroid_scene: PackedScene
@export var level: int

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
		
func next():
	level += 1
	print(level)
	get_tree().change_scene_to_file('res://Levels/level-' + str(level) + '.tscn')
	destroyAstroids()
	

func off_screen():
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
