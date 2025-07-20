extends EnemyMoveState


var timer: float = 0.0


func exit() -> void:
	super()
	timer = 0.0

func update(_delta: float) -> void:
	super(_delta)
	timer += _delta
	if timer > 1.0 && owner.nav_agent.distance_to_target() < 15:
		timer = 0.0
		if randi_range(0, 1) == 1:
			owner.get_node("StateMachine").transition_to("AttackJump")

func _on_target_reached():
	owner.get_node("StateMachine").transition_to("StateChooser")
