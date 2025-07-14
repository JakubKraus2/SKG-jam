extends State

func enter(_msg := {}) -> void:
	state_machine.owner.anim_player.play("movement")

func physics_update(delta: float) -> void:
	var player = state_machine.owner
	var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down", 0.4)
	var camera = player.camera
	var move_input = (camera.global_basis.z * input_vector.y + camera.global_basis.x * input_vector.x).normalized()
	move_input.y = 0.0

	if move_input.length() < 0.1:
		state_machine.transition_to("Idle")
		return
	
	# Rotation and movement
	player.movement_direction = move_input
	var target_yaw = Vector3.FORWARD.signed_angle_to(move_input, Vector3.UP)
	player.body_mesh.global_rotation.y = lerp_angle(player.body_mesh.rotation.y, target_yaw, player.rotation_speed * delta)

	# Movement
	var vertical_velocity = player.velocity.y
	player.velocity.y = 0
	player.velocity = player.velocity.move_toward(move_input * player.run_speed, player.run_acceleration * delta)
	player.velocity.y = vertical_velocity + player.gravity * delta

	player.move_and_slide()

	if Input.is_action_just_pressed("roll"):
		state_machine.transition_to("Roll")
	if Input.is_action_just_pressed("light_attack"):
		state_machine.transition_to("LightAttack1")
