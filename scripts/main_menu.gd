extends Button

func _pressed():
	Globals.toggle_sound_effects(true)
	get_tree().change_scene_to_file("res://menu.tscn")
