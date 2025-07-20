extends EnemyAttackBase

func _on_animation_finished(animation: String):
	owner.get_node("StateMachine").transition_to("Movement")
