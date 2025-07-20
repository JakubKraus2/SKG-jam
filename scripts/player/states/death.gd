extends State

func enter(_msg := {}) -> void:
	state_machine.owner.anim_player.animation_finished.connect(_on_animation_finished)
	state_machine.owner.velocity = Vector3.ZERO
	state_machine.owner.anim_player.play("death")

func exit() -> void:
	state_machine.owner.anim_player.animation_finished.disconnect(_on_animation_finished)


func _on_animation_finished(animation: String):
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()
	Music.set_stream(load("res://assets/sounds/music/crickets.wav"))
	Music.play()
