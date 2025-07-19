extends State


@export var damage: float = 10.0
@export var animation: String
@export var can_move: bool = false
@export var face_target: bool = false
@export var turning_speed: float = 10.0
@export var attack_move_speed: float = 5.0

@export_enum("normal", "knockdown", "launch") var attack_type: String = "normal"

func enter(_msg := {}) -> void:
	owner.anim_player.play(animation)
	owner.velocity = Vector3.ZERO
	owner.anim_player.animation_finished.connect(_on_animation_finished)
	owner.attack_type = attack_type
	owner.damage = damage

func exit() -> void:
	owner.anim_player.animation_finished.disconnect(_on_animation_finished)

func update(_delta: float) -> void:
	if can_move:
		owner.nav_agent.set_target_position(get_tree().get_first_node_in_group("player").global_position)
		owner.velocity = (owner.nav_agent.get_next_path_position() - owner.global_position).normalized() * attack_move_speed
		owner.move_and_slide()
	if face_target:
		var direction = (get_tree().get_first_node_in_group("player").global_position - owner.global_position).normalized()
		owner.rotation.y = lerp_angle(owner.rotation.y, atan2(direction.x, direction.z), _delta * turning_speed)


func _on_animation_finished(animation: String):
	owner.get_node("StateMachine").transition_to("Movement")
