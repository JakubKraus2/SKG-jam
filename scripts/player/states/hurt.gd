extends State


@export var animation: String = "hurt_normal"


func enter(_msg := {}) -> void:
	state_machine.owner.velocity = Vector3.ZERO
	state_machine.owner.anim_player.play(animation)
	owner.anim_player.animation_finished.connect(_on_animation_finished)

func exit() -> void:
	var player = state_machine.owner
	player.anim_player.animation_finished.disconnect(_on_animation_finished)


func _on_animation_finished(animation: String):
	owner.get_node("StateMachine").transition_to("Idle")
