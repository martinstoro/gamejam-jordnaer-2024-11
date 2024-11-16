extends CharacterBody3D
@onready var thruster: Node3D = $Thruster
@onready var explosion: Node3D = $Explosion
@onready var ship_mesh: Node3D = $ShipMesh
@onready var MainBoosterAudio: AudioStreamPlayer = $MainBooster
@onready var RotationBoosterAudio: AudioStreamPlayer = $RotationBooster

const MASS = 1.0
const ACCELLERATE_VEC = Vector3(0, 0, -20)
const ROTATE_ANGLE = 6
var is_alive = true

func _ready() -> void:
	thruster.disable_thrusters()

func _physics_process(delta: float) -> void:
	if is_alive:
		if Input.is_action_pressed("ui_up"):
			velocity += ACCELLERATE_VEC.rotated(Vector3.UP, rotation.y) * delta
			thruster.enable_thrusters()
			if !MainBoosterAudio.playing:
				MainBoosterAudio.play()
		if Input.is_action_just_released("ui_up"):
			thruster.disable_thrusters()
			MainBoosterAudio.stop()

		if Input.is_action_pressed("ui_left"):
			rotation.y += ROTATE_ANGLE * delta
			if !RotationBoosterAudio.playing:
				RotationBoosterAudio.play()
		if Input.is_action_just_released("ui_left"):
			RotationBoosterAudio.stop()

		if Input.is_action_pressed("ui_right"):
			rotation.y -= ROTATE_ANGLE * delta
			if !RotationBoosterAudio.playing:
				RotationBoosterAudio.play()
		if Input.is_action_just_released("ui_right"):
			RotationBoosterAudio.stop()
	else:
		velocity = Vector3(0,0,0)
	
	for index in range(get_slide_collision_count()):
		var collision = get_slide_collision(index)
		if collision.get_collider():
			print("I collided with ", collision.get_collider().IS_DANGER)
			if collision.get_collider().IS_DANGER: 
				die()
	
	if Input.is_key_pressed(KEY_R): 
		get_tree().reload_current_scene()
	
	move_and_slide()


func die():
	is_alive = false
	ship_mesh.visible = false
	thruster.disable_thrusters()
	explosion.explode()
	await get_tree().create_timer(2.0).timeout
	get_tree().reload_current_scene()

# BASIC MOVEMENT
#func _physics_process(delta: float) -> void:
	#var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if direction:
		#velocity.x += direction.x * SPEED
		#velocity.z += direction.z * SPEED
#
	#move_and_slide()
