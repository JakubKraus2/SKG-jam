extends Area3D
class_name TraumaCauser


@export var trauma_amount := 0.1
@export var trauma_reduction_rate := 1.0


func cause_trauma():
	var trauma_areas := get_overlapping_areas()
	for area in trauma_areas:
		if area.has_method("add_trauma"):
			area.trauma_reduction_rate = trauma_reduction_rate
			area.set_process(true)
			area.add_trauma(trauma_amount)


func set_variables(p_trauma_amount: float, p_trauma_reduction_rate: float):
	trauma_amount = p_trauma_amount
	trauma_reduction_rate = p_trauma_reduction_rate
