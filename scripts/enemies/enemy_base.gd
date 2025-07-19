extends CharacterBody3D


@export var speed: float = 3.0
@export var health: int = 70.0
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D



func _process(delta: float) -> void:
	velocity.y = -9.8 * delta


func _on_hurt_box_area_entered(area: Area3D) -> void:
	health -= 30
	if health <= 0:
		$StateMachine.transition_to("Death")
		remove_from_group("enemies")
		disable_colisions()
		return
	$StateMachine.transition_to("Hurt")


# Just to be sure
func disable_colisions():
	$HurtBox.set_deferred("monitoring", false)
	$HurtBox.set_deferred("monitorable", false)
	$Hitbox.set_deferred("monitoring", false)
	$Hitbox.set_deferred("monitorable", false)
	$CollisionShape3D.set_deferred("disabled", true)
