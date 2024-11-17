extends Node3D

@export var HAS_ASTROIDS = true
@export var ASTROID_SPAWN_TIME = 0.5

func _ready():
	if HAS_ASTROIDS:
		Globals.start_astroids()
		Globals.astroid_spawn_time(ASTROID_SPAWN_TIME)
	else:
		Globals.stop_astroids()
