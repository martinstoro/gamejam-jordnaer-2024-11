extends Node3D

@export var astroid_scene: PackedScene

func _ready():
	Globals.start_astroids()
	Globals.astroid_spawn_time(0.5)

func _on_astroid_timer_timeout() -> void:
	var astroid = astroid_scene.instantiate()
	var astroid_spawn_location = get_node("SpawnPath/SpawnLocation")
	astroid_spawn_location.progress_ratio = randf()

	var player_position = $Player.position
	astroid.initialize(astroid_spawn_location.position, player_position)

	add_child(astroid)
