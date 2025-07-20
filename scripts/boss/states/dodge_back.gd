extends State


@export var next_state: String
@export var desired_distance: float = 15.0
@export var dodge_speed: float = 8.0
@export var can_move: bool = false
@export var can_transition: bool = false


func enter(_msg := {}) -> void:
	owner.anim_player.play("dodge_back")
	owner.velocity = Vector3.ZERO
	owner.anim_player.animation_finished.connect(_on_animation_finished)

func update(_delta: float) -> void:
	if can_transition:
		if owner.global_position.distance_to(get_tree().get_first_node_in_group("player").global_position) <= desired_distance:
			owner.get_node("StateMachine").transition_to(next_state)
	if can_move:
		owner.nav_agent.set_target_position(get_tree().get_first_node_in_group("player").global_position)
		owner.velocity = -(owner.nav_agent.get_next_path_position() - owner.global_position).normalized() * dodge_speed
		owner.velocity.y = 0
		if owner.velocity.length() > 0:
			owner.rotation.y = lerp_angle(owner.rotation.y, atan2(-owner.velocity.x, -owner.velocity.z), _delta * 3.0)
		owner.move_and_slide()

func exit() -> void:
	owner.anim_player.animation_finished.disconnect(_on_animation_finished)
	can_transition = false


func _on_animation_finished(animation: String):
	owner.get_node("StateMachine").transition_to("Movement")
