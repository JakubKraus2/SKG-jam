extends State


func enter(_msg := {}) -> void:
	owner.anim_player.play("idle")
	owner.velocity = Vector3.ZERO
