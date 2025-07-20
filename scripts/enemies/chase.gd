extends State
class_name EnemyMoveState


@export var can_move: bool = true


func enter(_msg := {}) -> void:
	owner.anim_player.play("movement")
	owner.nav_agent.target_reached.connect(_on_target_reached)

func exit() -> void:
	owner.nav_agent.target_reached.disconnect(_on_target_reached)


func update(_delta: float) -> void:
	if can_move:
		owner.nav_agent.set_target_position(get_tree().get_first_node_in_group("player").global_position)
		owner.velocity = (owner.nav_agent.get_next_path_position() - owner.global_position).normalized() * owner.speed
		if owner.velocity.length() > 0:
			owner.rotation.y = lerp_angle(owner.rotation.y, atan2(owner.velocity.x, owner.velocity.z), _delta * 10.0)
		owner.move_and_slide()


func _on_target_reached():
	owner.get_node("StateMachine").transition_to("Attack")
