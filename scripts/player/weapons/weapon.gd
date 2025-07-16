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
	play_sound()
	spawn_particle()

func slow_down_animation():
	player.anim_player.set_speed_scale(0.1)
	await get_tree().create_timer(0.1).timeout
	player.anim_player.set_speed_scale(1.0)

func screen_shake():
	$TraumaCauser.cause_trauma()

func play_sound():
	player.get_node("ImpactAudio").play()

func spawn_particle():
	get_parent().get_node("ImpactParticle").restart()
