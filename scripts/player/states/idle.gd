extends State

func enter(_msg := {}) -> void:
	state_machine.owner.velocity = Vector3.ZERO
	state_machine.owner.anim_player.play("idle")

func physics_update(delta: float) -> void:
	var input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if input.length() > 0.1:
		state_machine.transition_to("Movement")
	
	if Input.is_action_just_pressed("roll"):
		state_machine.transition_to("Roll")
	
	if Input.is_action_just_pressed("light_attack"):
		state_machine.transition_to("LightAttack1")
	
	var player = state_machine.owner
	var body_mesh = player.body_mesh
	
	# If locked-on, rotate to face the target
	if player.is_locked_on and player.lock_target:
		var to_target = player.lock_target.global_position - player.global_position
		to_target.y = 0
		if to_target.length_squared() > 0.01:
			var target_yaw = Vector3.FORWARD.signed_angle_to(to_target.normalized(), Vector3.UP)
			body_mesh.rotation.y = lerp_angle(body_mesh.rotation.y, target_yaw, player.rotation_speed * delta)
