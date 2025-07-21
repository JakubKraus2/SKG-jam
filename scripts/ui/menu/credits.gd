extends Control


func _ready() -> void:
	hide()


func _on_texture_button_pressed() -> void:
	hide()


func _on_texture_button_mouse_entered() -> void:
	$TextureButton/Label.modulate = Color(0.563, 0.223, 0.204)
	$AudioHover.play()

func _on_texture_button_mouse_exited() -> void:
	$TextureButton/Label.modulate =  Color(1.0, 1.0, 1.0)
