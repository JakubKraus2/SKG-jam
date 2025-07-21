extends EnemyDeathState


func enter(_msg := {}) -> void:
	super()
	$"../../HealthBar".hide()
	Music.set_stream(load("res://assets/sounds/music/crickets.wav"))
	Music.play()
	VictoryPopup.get_node("AnimationPlayer").play("show")
	await owner.anim_player.animation_finished
	$"../../Hints".set_text("This is the end of the demo")
	$"../../Hints".play_animation()
	
	var tween = get_tree().create_tween()
	var healthbar = get_tree().get_root().get_child(-1).find_child("HealthBar")
	healthbar.set_process_mode(Node.PROCESS_MODE_DISABLED)
	tween.tween_property(healthbar, "modulate", Color(1, 1, 1, 0.0), 1.0)
