extends Control

func _ready() -> void:
	start_menu()
	Globals.start_astroids()

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/level-0.tscn")
	Globals.reset()

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_credits_pressed() -> void:
	credits_show()

func _on_back_pressed() -> void:
	start_menu()

func start_menu() -> void:
	$StartMenu.show()
	$CreditsMenu.hide()
	
func credits_show() -> void:
	$StartMenu.hide()
	$CreditsMenu.show()
