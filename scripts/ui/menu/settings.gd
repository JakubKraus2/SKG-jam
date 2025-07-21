extends Control


@onready var temp_volume: float = Settings.volume
@onready var temp_sensitivity: float = Settings.mouse_sensitivity
@onready var temp_window_mode: int = Settings.window_mode


func _ready() -> void:
	hide()
	AudioServer.set_bus_volume_db(0, temp_volume)
	$SliderContainer/Volume/VolumeSlider.value = temp_volume
	$SliderContainer/Sensitivity/SensitivitySlider.value = temp_sensitivity
	$WindowContainer/OptionButton.select(temp_window_mode)
	$SliderContainer/Volume/CurrentValueLabel.text = str($SliderContainer/Volume/VolumeSlider.value)
	$SliderContainer/Sensitivity/CurrentValueLabel.text = str($SliderContainer/Sensitivity/SensitivitySlider.value)
	$WindowContainer/OptionButton.select(temp_window_mode)


func _on_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, value)
	$SliderContainer/Volume/CurrentValueLabel.text = str($SliderContainer/Volume/VolumeSlider.value)
	temp_volume = value

func _on_sensitivity_slider_value_changed(value: float) -> void:
	$SliderContainer/Sensitivity/CurrentValueLabel.text = str($SliderContainer/Sensitivity/SensitivitySlider.value)
	temp_sensitivity = value


func _on_cancel_button_pressed() -> void:
	AudioServer.set_bus_volume_db(0, Settings.volume)
	$SliderContainer/Volume/VolumeSlider.value = Settings.volume
	$SliderContainer/Sensitivity/SensitivitySlider.value = Settings.mouse_sensitivity
	$WindowContainer/OptionButton.select(Settings.window_mode)
	temp_window_mode = Settings.window_mode
	temp_sensitivity = Settings.mouse_sensitivity
	temp_volume = Settings.volume
	match Settings.window_mode:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	hide()


func _on_apply_button_pressed() -> void:
	Settings.volume = temp_volume
	Settings.mouse_sensitivity = temp_sensitivity
	Settings.window_mode = temp_window_mode
	AudioServer.set_bus_volume_db(0, Settings.volume)
	$WindowContainer/OptionButton.select(Settings.window_mode)


func _on_option_button_item_selected(index: int) -> void:
	temp_window_mode = index
	match temp_window_mode:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
