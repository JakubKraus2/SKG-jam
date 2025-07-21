extends CharacterBody3D


@export var speed: float = 3.0
@export var health: int = 70.0
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@onready var state_machine: StateMachine = $StateMachine

var damage: float
var attack_type: String


func _ready() -> void:
	$HealthBar.max_value = health
	$HealthBar.value = health
	$HealthBar/DamageBar.max_value = health
	$HealthBar/DamageBar.value = health
	$HealthBar.hide()

func _process(delta: float) -> void:
	velocity.y = -9.8 * delta


func _on_hurt_box_area_entered(area: Area3D) -> void:
	health -= 30
	$HealthBar.value = health
	$HealthBar/Timer.start()
	if health <= 0:
		$StateMachine.transition_to("Death")
		remove_from_group("enemies")
		disable_colisions()
		return


# Just to be sure
func disable_colisions():
	$HurtBox.set_deferred("monitoring", false)
	$HurtBox.set_deferred("monitorable", false)
	$Hitbox.set_deferred("monitoring", false)
	$Hitbox.set_deferred("monitorable", false)
	$CollisionShape3D.set_deferred("disabled", true)


func _on_timer_timeout() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($HealthBar/DamageBar, "value", health, 0.2).set_ease(Tween.EASE_OUT)
	var tween2 = get_tree().create_tween()
	tween2.tween_property($HealthBar/TextureRect, "position:x", (health * 9.56)/6, 0.2).set_ease(Tween.EASE_OUT)


func _on_hitbox_area_entered(area: Area3D) -> void:
	PlayerEvents.take_damage.emit(damage, attack_type)
