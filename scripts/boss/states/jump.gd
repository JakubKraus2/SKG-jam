extends State


@export var next_state: String
@export var can_move: bool = false


func enter(_msg := {}) -> void:
	owner.anim_player.play("jump")
	owner.velocity = Vector3.ZERO
	owner.anim_player.animation_finished.connect(_on_animation_finished)

func update(_delta: float) -> void:
	if can_move:
		owner.velocity.y = 40
		owner.move_and_slide()

func exit() -> void:
	owner.anim_player.animation_finished.disconnect(_on_animation_finished)


func _on_animation_finished(animation: String):
	owner.get_node("StateMachine").transition_to(next_state)
