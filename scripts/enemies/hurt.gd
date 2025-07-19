extends State


func enter(_msg := {}) -> void:
	owner.anim_player.play("hurt_" + str(randi_range(1, 2)))
	owner.velocity = Vector3.ZERO
	owner.anim_player.animation_finished.connect(_on_animation_finished)

func exit() -> void:
	owner.anim_player.animation_finished.disconnect(_on_animation_finished)


func _on_animation_finished(animation: String):
	owner.get_node("StateMachine").transition_to("Movement")
