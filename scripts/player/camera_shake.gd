extends Area3D

@onready var initial_rotation = get_parent().rotation_degrees

var trauma_reduction_rate := 1.0

@export var noise: FastNoiseLite
@export var noise_speed := 50.0

var trauma := 0.0
var time := 0.0

var max_x := 10.0
var max_y := 10.0
var max_z := 5.0

func _ready():
	set_process(false)

func _process(delta):
	time += delta
	trauma = max(trauma - delta * trauma_reduction_rate, 0.0)
	
	var shake_intensity = get_shake_intensity()
	var noise_x = get_noise_from_seed(0)
	var noise_y = get_noise_from_seed(1)
	var noise_z = get_noise_from_seed(2)
	
	get_parent().rotation_degrees = initial_rotation + Vector3(
		max_x * shake_intensity * noise_x,
		max_y * shake_intensity * noise_y,
		max_z * shake_intensity * noise_z
	)

	if trauma == 0.0:
		set_process(false)

func add_trauma(trauma_amount: float):
	trauma = clamp(trauma + trauma_amount, 0.0, 1.0)
	set_process(true) # Make sure it shakes again if you add trauma

func get_shake_intensity() -> float:
	return trauma * trauma

func get_noise_from_seed(_seed: int) -> float:
	noise.seed = _seed
	return noise.get_noise_1d(time * noise_speed)
