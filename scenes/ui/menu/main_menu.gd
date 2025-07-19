extends Control



func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/Swamp.tscn")


func _on_play_button_2_pressed() -> void:
	pass # Replace with function body.


func _on_play_button_3_pressed() -> void:
	pass # Replace with function body.


func _on_play_button_4_pressed() -> void:
	get_tree().quit()


func _on_play_button_mouse_entered() -> void:
	$ButtonContainer/PlayButton/Label.modulate = Color(0.563, 0.223, 0.204)


func _on_play_button_mouse_exited() -> void:
	$ButtonContainer/PlayButton/Label.modulate = Color.WHITE


func _on_play_button_2_mouse_entered() -> void:
	$ButtonContainer/PlayButton2/Label.modulate = Color(0.563, 0.223, 0.204)


func _on_play_button_2_mouse_exited() -> void:
	$ButtonContainer/PlayButton2/Label.modulate = Color.WHITE


func _on_play_button_3_mouse_entered() -> void:
	$ButtonContainer/PlayButton3/Label.modulate = Color(0.563, 0.223, 0.204)


func _on_play_button_3_mouse_exited() -> void:
	$ButtonContainer/PlayButton3/Label.modulate = Color.WHITE


func _on_play_button_4_mouse_entered() -> void:
	$ButtonContainer/PlayButton4/Label.modulate = Color(0.563, 0.223, 0.204)


func _on_play_button_4_mouse_exited() -> void:
	$ButtonContainer/PlayButton4/Label.modulate = Color.WHITE
