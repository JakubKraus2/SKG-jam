extends EnemyDeathState


func enter(_msg := {}) -> void:
	super()
	$"../../HealthBar".hide()
