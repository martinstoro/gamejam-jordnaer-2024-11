extends Node
@onready var restart_button: Button = $WinLoseUI/Container/RestartButton
@onready var next_level_button: Button = $WinLoseUI/Container/NextLevelButton
@onready var win_lose_ui: CenterContainer = $WinLoseUI
@onready var win_lose_label: Label = $WinLoseUI/Container/WinLoseLabel

func _process(delta):
	if Input.is_key_pressed(KEY_R): 
		get_tree().reload_current_scene()
		reset()
	if Input.is_key_pressed(KEY_Z): 
		get_tree().change_scene_to_file("res://Main3D.tscn")
		# REMEMBER TO REMOVE BEFORE 16:00!!!

func lose():
	win_lose_ui.visible = true
	restart_button.visible = true
	next_level_button.visible = false
	win_lose_label.text = "You died"

func win():
	win_lose_ui.visible = true
	restart_button.visible = false
	next_level_button.visible = true
	win_lose_label.text = "You killed 8.2 billion people!"

func reset():
	win_lose_ui.visible = false
