extends EnemyAttackBase


@export var next_state: String
@export var desired_distance: float = 10.0
@export var can_transition: bool = false


func exit() -> void:
	super()
	can_transition = false

func update(_delta: float) -> void:
	super(_delta)
	if can_transition:
		if owner.global_position.distance_to(get_tree().get_first_node_in_group("player").global_position) <= desired_distance:
			owner.get_node("StateMachine").transition_to(next_state)


func _on_animation_finished(animation: String):
	owner.get_node("StateMachine").transition_to("Movement")
