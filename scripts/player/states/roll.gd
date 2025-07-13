extends State

var roll_duration := 0.6
var timer := 0.0
var roll_direction := Vector3.ZERO

func enter(_msg := {}) -> void:
	var player = state_machine.owner
	var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down", 0.4)
	
	# Calculate roll direction
	var cam_forward = player.camera.global_basis.z
	var cam_right = player.camera.global_basis.x
	roll_direction = (cam_forward * input_vector.y + cam_right * input_vector.x).normalized()
	roll_direction.y = 0
	
	# If no input, roll forward relative to players mesh
	if roll_direction.length() == 0:
		roll_direction = -player.body_mesh.global_transform.basis.z.normalized()
		roll_direction.y = 0
	
	# Set movement direction and instantly rotate mesh
	player.movement_direction = roll_direction
	var target_yaw = Vector3.FORWARD.signed_angle_to(roll_direction, Vector3.UP)
	player.body_mesh.rotation.y = target_yaw
	
	timer = 0.0
	player.anim_player.play("roll")

func physics_update(delta: float) -> void:
	var player = state_machine.owner
	timer += delta
	
	player.velocity = roll_direction * player.run_speed * 1.5
	player.velocity.y += player.gravity * delta
	player.move_and_slide()
	
	if timer >= roll_duration:
		state_machine.transition_to("Idle")
