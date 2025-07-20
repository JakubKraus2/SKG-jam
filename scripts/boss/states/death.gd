extends EnemyDeathState


func enter(_msg := {}) -> void:
	super()
	$"../../HealthBar".hide()
	Music.set_stream(load("res://assets/sounds/music/crickets.wav"))
	Music.play()
