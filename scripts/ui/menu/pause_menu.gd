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
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _on_resume_button_pressed() -> void:
	hide()
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _on_options_button_pressed() -> void:
	$Settings.show()


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/menu/main_menu.tscn")
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_exit_game_button_pressed() -> void:
	get_tree().quit()
