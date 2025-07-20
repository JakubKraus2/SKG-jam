extends HintInteraction


func _ready() -> void:
	super()
	$"../../HealthBar".hide()
	$"../../HealthBar".set_process_mode(Node.PROCESS_MODE_DISABLED)
	$"../../HealthBar".set_modulate(Color(1, 1, 1, 0))


func _on_body_entered(body: Node3D) -> void:
	super(body)
	await get_tree().create_timer(0.8).timeout
	$"../../HealthBar".show()
	$"../../HealthBar".set_process_mode(Node.PROCESS_MODE_INHERIT)
	var tween = get_tree().create_tween()
	tween.tween_property($"../../HealthBar", "modulate", Color(1, 1, 1, 1), 1.0)
