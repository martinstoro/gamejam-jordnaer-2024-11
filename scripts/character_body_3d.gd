extends CharacterBody3D

#const SPEED = 1

const MASS = 1.0
const ACCELLERATE_VEC = Vector3(0, 0, -20)
const ROTATE_ANGLE = 6

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_up"):
		#velocity += direction
		velocity += ACCELLERATE_VEC.rotated(Vector3.UP, rotation.y) * delta

	if Input.is_action_pressed("ui_left"):
		rotation.y += ROTATE_ANGLE * delta
	if Input.is_action_pressed("ui_right"):
		rotation.y -= ROTATE_ANGLE * delta

	move_and_slide()

# BASIC MOVEMENT
#func _physics_process(delta: float) -> void:
	#var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if direction:
		#velocity.x += direction.x * SPEED
		#velocity.z += direction.z * SPEED
#
	#move_and_slide()
