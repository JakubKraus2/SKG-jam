extends Area3D
class_name HintInteraction


@export var text: String


func _ready() -> void:
	if PlayerEvents.boss_activated:
		queue_free()
		return

func _on_body_entered(body: Node3D) -> void:
	$"../../Hints".set_text(text)
	$"../../Hints".play_animation()
