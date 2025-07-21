extends State


func enter(_msg := {}) -> void:
	owner.velocity = Vector3.ZERO
	
	var options := []

	var distance = owner.nav_agent.distance_to_target()
	var angle_to_player = rad_to_deg(owner.global_transform.basis.z.normalized().angle_to(
		get_tree().get_first_node_in_group("player").global_position - owner.global_position))
	var right_dir = owner.global_transform.basis.x.normalized()
	var dot = right_dir.dot((get_tree().get_first_node_in_group("player").global_position - owner.global_position).normalized())
	
	if distance <= owner.nav_agent.get_target_desired_distance():
		options.append("DodgeBack")
	
	# Close range
	if distance <= owner.nav_agent.get_target_desired_distance():
		options.append("AttackSmash")
		options.append("AttackCombo1")
	# Check angles
	if distance <= owner.nav_agent.get_target_desired_distance():
		if angle_to_player > 120.0: # Behind
			options.clear()
			options.append("AttackJump")
			options.append("AttackSmash")
		elif angle_to_player > 60.0 && dot < -0.5: # Right Side
			options.clear()
			options.append("AttackRight")
			options.append("AttackCombo1")
		elif angle_to_player > 60.0 && dot > 0.5: # Left Side
			options.clear()
			options.append("AttackLeft")
			options.append("AttackCombo1")	
	# Mid range
	elif distance > owner.nav_agent.get_target_desired_distance()*2 && distance < owner.nav_agent.get_target_desired_distance()*4:
		options.clear()
		options.append("AttackJump")
	
	# If no valid attacks, chase
	if options.is_empty():
		state_machine.transition_to("Movement")
		return

	# Choose randomly from valid options
	var chosen = options[randi() % options.size()]
	
	state_machine.transition_to(chosen)
