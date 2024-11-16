extends Control


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Main3D.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_credits_pressed() -> void:
	pass

func _process(delta):
	if Input.is_key_pressed(KEY_R): 
		get_tree().change_scene_to_file("res://Main3D.tscn")
