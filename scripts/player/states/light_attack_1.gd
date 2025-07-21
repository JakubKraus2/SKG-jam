extends State


@export var animation: String
@export var nextState: State
@export var speed: float = 6.0
@export var can_move: bool = false
@export var ready_to_attack: bool = false
@export var can_transition: bool = false

var attack_direction := Vector3.ZERO
var queue_attack: bool = false


func enter(_msg := {}) -> void:
	ready_to_attack = false
	can_transition = false
	can_move = false
	var player = state_machine.owner
	player.anim_player.animation_finished.connect(_on_animation_finished)

	# Determine attack direction
	if player.is_locked_on and player.lock_target:
		attack_direction = player.lock_target.global_position - player.global_position
		attack_direction.y = 0
		attack_direction = attack_direction.normalized()
	else:
		var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down", 0.4)
		var cam_forward = player.camera.global_basis.z
		var cam_right = player.camera.global_basis.x
		attack_direction = (cam_forward * input_vector.y + cam_right * input_vector.x).normalized()
		attack_direction.y = 0

		if attack_direction.length() == 0:
			attack_direction = -player.body_mesh.global_transform.basis.z.normalized()
			attack_direction.y = 0

	player.movement_direction = attack_direction
	player.anim_player.play(animation)

	
	# If no input, attack forward relative to players mesh
	if attack_direction.length() == 0:
		attack_direction = -player.body_mesh.global_transform.basis.z.normalized()
		attack_direction.y = 0
	
	# Set movement direction and instantly rotate mesh
	player.movement_direction = attack_direction
	#var target_yaw = Vector3.FORWARD.signed_angle_to(attack_direction, Vector3.UP)
	#player.body_mesh.rotation.y = target_yaw
	
	player.anim_player.play(animation)

func exit() -> void:
	var player = state_machine.owner
	player.anim_player.animation_finished.disconnect(_on_animation_finished)
	$"../../Armature/Skeleton3D/Weapon/Cube_003/Hitbox/CollisionShape3D".set_deferred("disabled", true)
	#PlayerEvents.take_damage.disconnect(_on_take_damage)

func physics_update(delta: float) -> void:
	var player = state_machine.owner
	var target_yaw = Vector3.FORWARD.signed_angle_to(attack_direction, Vector3.UP)
	player.body_mesh.rotation.y = lerp_angle(player.body_mesh.rotation.y, target_yaw, delta * 12.0)
	
	if can_move:
		player.velocity = attack_direction * speed
		player.move_and_slide()
	
	if player.anim_player.current_animation_position >= player.anim_player.current_animation_length/6 && Input.is_action_just_pressed("light_attack"):
		queue_attack = true
	
	if ready_to_attack && queue_attack:
		state_machine.transition_to(str(nextState))
		queue_attack = false
		return
	if can_transition:
		var input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		if input.length() > 0.1:
			state_machine.transition_to("Movement")
		if Input.is_action_just_pressed("roll"):
			state_machine.transition_to("Roll")


func _on_animation_finished(animation: String):
	state_machine.transition_to("Idle")
