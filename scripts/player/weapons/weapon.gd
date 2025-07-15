extends MeshInstance3D
class_name Weapon


var hitbox: Area3D
var player: CharacterBody3D


func _ready() -> void:
	player = owner
	hitbox = get_child(-1)
	hitbox.area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area3D):
	screen_shake()
	slow_down_animation()

func slow_down_animation():
	player.anim_player.set_speed_scale(0.1)
	await get_tree().create_timer(0.1).timeout
	player.anim_player.set_speed_scale(1.0)

func screen_shake():
	$TraumaCauser.cause_trauma()

#func show_impact_particle():
	#impact_particle.rotation = get_parent().global_rotation
	#impact_particle.global_position = global_position
	#var tween = get_tree().create_tween()
	#tween.tween_property(impact_particle, "modulate", Color(1, 1, 1, 0.7), 0.05)
	#await tween.finished
	#var tween2 = get_tree().create_tween()
	#tween2.tween_property(impact_particle, "modulate", Color(1, 1, 1, 0), 0.1)
