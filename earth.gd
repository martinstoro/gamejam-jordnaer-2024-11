extends MeshInstance3D


func _physics_process(delta: float) -> void:

	rotation += Vector3(0, 0.01, 0.01)
