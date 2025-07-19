extends TextureProgressBar



func _ready() -> void:
	max_value = 100
	value = 100
	$DamageBar.max_value = 100
	$DamageBar.value = 100
	PlayerEvents.take_damage.connect(_on_take_damage)


func check_death():
	if value <= 0:
		PlayerEvents.death.emit()
		return true


func _on_take_damage(damage: float, attack_type: String):
	if damage > 0:
		$Timer.start()
		value -= damage
		if !check_death():
			get_tree().get_first_node_in_group("player").get_node("StateMachine").transition_to("Hurt" + attack_type.capitalize())
	else:
		var new_value = min(value - damage, 100)
		var tween = get_tree().create_tween()
		var tween2 = get_tree().create_tween()
		var tween3 = get_tree().create_tween()
		tween.tween_property(self, "value", new_value, 0.3).set_ease(Tween.EASE_IN)
		tween2.tween_property($DamageBar, "value", new_value, 0.2).set_ease(Tween.EASE_IN)
		tween3.tween_property($TextureRect, "position:x", new_value * 3.17, 0.1).set_ease(Tween.EASE_IN)


func _on_timer_timeout() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($DamageBar, "value", value, 0.2).set_ease(Tween.EASE_OUT)
	var tween2 = get_tree().create_tween()
	tween2.tween_property($TextureRect, "position:x", value * 3.17, 0.2).set_ease(Tween.EASE_OUT)
