extends Area3D


@export var boss: CharacterBody3D


func _on_body_entered(body: Node3D) -> void:
	boss.state_machine.transition_to("Jump")
	$"../InvisWall/CollisionShape3D".set_deferred("disabled", false)
	$"../InvisWall".show()
	PlayerEvents.boss_activated = true
	queue_free()
