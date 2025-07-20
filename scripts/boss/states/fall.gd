extends State


@export var next_state: String


func enter(_msg := {}) -> void:
	owner.anim_player.play("fall")
	owner.velocity = Vector3.ZERO

func update(_delta: float) -> void:
	owner.velocity.x = (get_tree().get_first_node_in_group("player").global_position.x - owner.global_position.x) * 1.5
	owner.velocity.z = (get_tree().get_first_node_in_group("player").global_position.z - owner.global_position.z) * 1.5
	owner.velocity.y = -20
	owner.move_and_slide()
	if owner.is_on_floor():
		owner.get_node("StateMachine").transition_to(next_state)
