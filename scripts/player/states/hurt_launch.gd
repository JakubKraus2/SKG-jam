extends PlayerHurtState


var launch_direction
@export var can_move: bool = true


func enter(_msg := {}) -> void:
	super()
	launch_direction = owner.body_mesh.global_transform.basis.z.normalized()
	launch_direction.y = 0
	owner.movement_direction = launch_direction

func physics_update(delta: float) -> void:
	if can_move:
		var player = state_machine.owner
		
		player.velocity = launch_direction * player.run_speed * 3.0
		player.velocity.y += player.gravity * delta
		player.move_and_slide()
