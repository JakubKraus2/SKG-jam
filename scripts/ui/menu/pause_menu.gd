extends Control


func _ready() -> void:
	hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		visible = !visible
		get_tree().paused = visible
		if visible:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			$Settings.hide()
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _on_resume_button_pressed() -> void:
	hide()
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _on_options_button_pressed() -> void:
	$Settings.show()


func _on_main_menu_button_pressed() -> void:
	Transitions.get_node("AnimationPlayer").play("show")
	await Transitions.get_node("AnimationPlayer").animation_finished
	get_tree().change_scene_to_file("res://scenes/ui/menu/main_menu.tscn")
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$AudioConfirm.play()


func _on_exit_game_button_pressed() -> void:
	get_tree().quit()



func _on_resume_button_mouse_entered() -> void:
	$ButtonContainer/ResumeButton/Label.modulate = Color(0.563, 0.223, 0.204)
	$AudioHover.play()

func _on_resume_button_mouse_exited() -> void:
	$ButtonContainer/ResumeButton/Label.modulate = Color(1.0, 1.0, 1.0)


func _on_options_button_mouse_entered() -> void:
	$ButtonContainer/OptionsButton/Label.modulate = Color(0.563, 0.223, 0.204)
	$AudioHover.play()

func _on_options_button_mouse_exited() -> void:
	$ButtonContainer/OptionsButton/Label.modulate = Color(1.0, 1.0, 1.0)


func _on_main_menu_button_mouse_entered() -> void:
	$ButtonContainer/MainMenuButton/Label.modulate = Color(0.563, 0.223, 0.204)
	$AudioHover.play()

func _on_main_menu_button_mouse_exited() -> void:
	$ButtonContainer/MainMenuButton/Label.modulate = Color(1.0, 1.0, 1.0)


func _on_exit_game_button_mouse_entered() -> void:
	$ButtonContainer/ExitGameButton/Label.modulate = Color(0.563, 0.223, 0.204)
	$AudioHover.play()

func _on_exit_game_button_mouse_exited() -> void:
	$ButtonContainer/ExitGameButton/Label.modulate =  Color(1.0, 1.0, 1.0)
