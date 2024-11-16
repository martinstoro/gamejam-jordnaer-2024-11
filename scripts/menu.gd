extends Control

func _ready() -> void:
	start_menu()

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Main3D.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_credits_pressed() -> void:
	credits_show()

func _process(delta):
	if Input.is_key_pressed(KEY_R): 
		get_tree().change_scene_to_file("res://Main3D.tscn")

func _on_back_pressed() -> void:
	start_menu()

func start_menu() -> void:
	$MarginContainer/VBoxContainer/Start.show()
	$MarginContainer/VBoxContainer/Credits.show()
	$MarginContainer/VBoxContainer/Quit.show()
	$MarginContainer/VBoxContainer/Back.hide()
	$CreditKyrill.hide()
	$CreditMads.hide()
	$CreditMartin.hide()
	$CreditMarkus.hide()
	
func credits_show() -> void:
	$MarginContainer/VBoxContainer/Start.hide()
	$MarginContainer/VBoxContainer/Credits.hide()
	$MarginContainer/VBoxContainer/Quit.hide()
	$MarginContainer/VBoxContainer/Back.show()
	$CreditKyrill.show()
	$CreditMads.show()
	$CreditMartin.show()
	$CreditMarkus.show()
