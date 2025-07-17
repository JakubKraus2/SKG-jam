extends CharacterBody3D

@export_group("Movement")
@export var run_speed := 6.0
@export var run_acceleration := 50.0
@export var rotation_speed := 10.0
@export var stop_threshold := 5.0

@export_group("Camera")
@export_range(0.0, 1.0) var mouse_sensitivity := 0.05
@export var camera_tilt_up_limit := PI / 4
@export var camera_tilt_down_limit := -PI / 3

var gravity := -9.8
var camera_input := Vector2.ZERO
@onready var movement_direction := Vector3.FORWARD
@onready var spawn_position := global_position

@onready var camera_pivot: Node3D = $CamOrigin
@onready var camera: Camera3D = $CamOrigin/SpringArm3D/Camera3D
@onready var body_mesh = $Armature
@onready var anim_player: AnimationPlayer = $AnimationPlayer

@export_group("Lock-on")
var is_locked_on: bool = false
var lock_target = null #make this characterBody3D in the future
@export var lock_range: float = 15.0

var footsteps_water = load("res://resources/player/footsteps_water.tres")
var footsteps_ground = load("res://resources/player/footsteps_ground.tres")

var current_surface_type = "ground"


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$CamOrigin/SpringArm3D.add_excluded_object(self)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		camera_input.x = -event.relative.x * mouse_sensitivity
		camera_input.y = -event.relative.y * mouse_sensitivity

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("lock_on"):
		if is_locked_on:
			lock_target.get_node("LockOn").hide()
			is_locked_on = false
			lock_target = null
		else:
			lock_target = find_closest_target()
			is_locked_on = lock_target != null


func _physics_process(delta: float) -> void:
	if is_locked_on and lock_target:
		var to_target = (lock_target.global_position - global_position)
		to_target.y = 0
		movement_direction = to_target.normalized()
	
		var look_dir := movement_direction
		var new_rot_y := atan2(-look_dir.x, -look_dir.z)
		camera_pivot.rotation.y = lerp_angle(camera_pivot.rotation.y, new_rot_y, rotation_speed * delta)
		camera_pivot.rotation.x = lerp_angle(camera_pivot.rotation.x, -0.2, rotation_speed * delta)
	else:
		camera_pivot.rotation.x += camera_input.y * delta
		camera_pivot.rotation.x = clamp(camera_pivot.rotation.x, camera_tilt_down_limit, camera_tilt_up_limit)
		camera_pivot.rotation.y += camera_input.x * delta
		camera_input = Vector2.ZERO


func find_closest_target() -> Node3D:
	var result = null
	var min_distance := lock_range
	
	for enemy in get_tree().get_nodes_in_group("enemies"):
		if not enemy is Node3D: continue
		var distance = global_position.distance_to(enemy.global_position)
		if distance < min_distance:
			min_distance = distance
			result = enemy
	if result:
		result.get_node("LockOn").show()
	return result


func _on_water_entered(area: Area3D):
	current_surface_type = "water"

func _on_water_exited(area: Area3D):
	current_surface_type = "ground"
