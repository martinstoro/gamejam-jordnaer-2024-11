extends CharacterBody3D
@onready var thruster: Node3D = $Thruster
@onready var explosion: Node3D = $Explosion
@onready var left_air_thruster: Node3D = $LeftAirThruster
@onready var right_air_thruster: Node3D = $RightAirThruster

@onready var ship_mesh: Node3D = $ShipMesh
@onready var MainBoosterAudio: AudioStreamPlayer = $MainBooster
@onready var RotationBoosterAudio: AudioStreamPlayer = $RotationBooster
@onready var PlayerExplosionAudio: AudioStreamPlayer = $PlayerExplosion
@export var LET_GO = Vector3(0, 0, 0)

const MASS = 1.0
const ACCELLERATE_VEC = Vector3(0, 0, -20)
const ROTATE_ANGLE = 6
var is_alive = true
var speed = Vector3(0, 0, 0)

func _ready() -> void:
	thruster.disable_thrusters()
	left_air_thruster.disable_airthruster()
	right_air_thruster.disable_airthruster()

func _physics_process(delta: float) -> void:
	if is_alive:
		if Input.is_action_pressed("ui_up"):
			speed += ACCELLERATE_VEC.rotated(Vector3.UP, rotation.y) * delta 
			thruster.enable_thrusters()
			if !MainBoosterAudio.playing:
				MainBoosterAudio.play()
		if Input.is_action_just_released("ui_up"):
			thruster.disable_thrusters()
			MainBoosterAudio.stop()
			velocity = speed
			LET_GO = true
			

		if Input.is_action_pressed("ui_left"):
			right_air_thruster.enable_airthruster()
			rotation.y += ROTATE_ANGLE * delta
			if !RotationBoosterAudio.playing:
				RotationBoosterAudio.play()
		if Input.is_action_just_released("ui_left"):
			RotationBoosterAudio.stop()
			right_air_thruster.disable_airthruster()

		if Input.is_action_pressed("ui_right"):
			left_air_thruster.enable_airthruster()
			rotation.y -= ROTATE_ANGLE * delta
			if !RotationBoosterAudio.playing:
				RotationBoosterAudio.play()
		if Input.is_action_just_released("ui_right"):
			RotationBoosterAudio.stop()
			left_air_thruster.disable_airthruster()
	
		for index in range(get_slide_collision_count()):
			var collision = get_slide_collision(index)
			if collision.get_collider():
				print("I collided with ", collision.get_collider().IS_DANGER)
				if collision.get_collider().IS_DANGER: 
					die()
				else:
					collision.get_collider().explode()
					die()

	else:
		velocity = Vector3(0,0,0)
	
	if Input.is_key_pressed(KEY_R): 
		get_tree().reload_current_scene()
	
	move_and_slide()


func die():
	is_alive = false
	ship_mesh.visible = false
	thruster.disable_thrusters()
	MainBoosterAudio.stop()
	RotationBoosterAudio.stop()
	right_air_thruster.disable_airthruster()
	RotationBoosterAudio.stop()
	left_air_thruster.disable_airthruster()
	PlayerExplosionAudio.play()
	explosion.explode()


# BASIC MOVEMENT
#func _physics_process(delta: float) -> void:
	#var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if direction:
		#velocity.x += direction.x * SPEED
		#velocity.z += direction.z * SPEED
#
	#move_and_slide()
