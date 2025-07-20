extends State


@export var next_state: String


func enter(_msg := {}) -> void:
	owner.anim_player.play("land")
	owner.velocity = Vector3.ZERO
	owner.anim_player.animation_finished.connect(_on_animation_finished)

func exit() -> void:
	owner.anim_player.animation_finished.disconnect(_on_animation_finished)
	$"../../HealthBar".show()
	owner.set_collision_mask_value(1, true)


func _on_animation_finished(animation: String):
	owner.get_node("StateMachine").transition_to(next_state)
