extends Button

@export var level: int

func _pressed():
	Globals.set_level(level-1)
	Globals.next()
	Globals.reset()
	Globals.toggle_sound_effects(false)
