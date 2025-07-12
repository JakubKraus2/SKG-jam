extends CharacterBody3D

@export_group("Movement")
@export var run_speed := 6.0
@export var run_acceleration := 50.0
@export var rotation_speed := 8.0
@export var stop_threshold := 5.0

@export_group("Camera")
@export_range(0.0, 1.0) var mouse_sensitivity := 0.05
@export var camera_tilt_up_limit := PI / 4
@export var camera_tilt_down_limit := -PI / 3

var gravity := -9.8
var camera_input := Vector2.ZERO
@onready var movement_direction := global_basis.z
@onready var spawn_position := global_position

@onready var camera_pivot: Node3D = $CamOrigin
@onready var camera: Camera3D = $CamOrigin/SpringArm3D/Camera3D
@onready var body_mesh = $Cube

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$CamOrigin/SpringArm3D.add_excluded_object(self)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		camera_input.x = -event.relative.x * mouse_sensitivity
		camera_input.y = -event.relative.y * mouse_sensitivity

func _physics_process(delta: float) -> void:
	# Camera rotation
	camera_pivot.rotation.x += camera_input.y * delta
	camera_pivot.rotation.x = clamp(camera_pivot.rotation.x, camera_tilt_down_limit, camera_tilt_up_limit)
	camera_pivot.rotation.y += camera_input.x * delta
	camera_input = Vector2.ZERO

	# Movement input
	var input_vector := Input.get_vector("move_left", "move_right", "move_up", "move_down", 0.4)
	var cam_forward := camera.global_basis.z
	var cam_right := camera.global_basis.x
	var move_input := cam_forward * input_vector.y + cam_right * input_vector.x
	move_input.y = 0.0
	move_input = move_input.normalized()

	if move_input.length() > 0.2:
		movement_direction = move_input

	var target_yaw := Vector3.FORWARD.signed_angle_to(movement_direction, Vector3.UP)
	body_mesh.global_rotation.y = lerp_angle(body_mesh.rotation.y, target_yaw, rotation_speed * delta)

	# Movement and gravity
	var vertical_velocity := velocity.y
	velocity.y = 0.0
	velocity = velocity.move_toward(move_input * run_speed, run_acceleration * delta)

	if move_input.is_zero_approx() and velocity.length_squared() < stop_threshold:
		velocity = Vector3.ZERO

	velocity.y = vertical_velocity + gravity * delta
	move_and_slide()
