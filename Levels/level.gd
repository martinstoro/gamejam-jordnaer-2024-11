extends Node3D

@export var HAS_ASTROIDS = true
@export var ASTROID_FREQUENCY = 0.5

func _ready():
	if HAS_ASTROIDS:
		Globals.start_astroids()
		Globals.astroid_spawn_time(ASTROID_FREQUENCY)
	else:
		Globals.stop_astroids()
