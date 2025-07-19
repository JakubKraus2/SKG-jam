extends State


func enter(_msg := {}) -> void:
	owner.anim_player.play("death")
	owner.velocity = Vector3.ZERO
	get_tree().get_first_node_in_group("player").is_locked_on = false
	$"../../LockOn".hide()
