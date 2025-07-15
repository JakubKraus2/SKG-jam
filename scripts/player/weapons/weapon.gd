extends MeshInstance3D
class_name Weapon


func _ready() -> void:
	$Area3D.area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area3D):
	print("hit")
