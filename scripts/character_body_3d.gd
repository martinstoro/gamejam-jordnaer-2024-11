extends CharacterBody3D

@export var isForLoading: bool = false

@onready var thruster: Node3D = $Thruster
@onready var explosion: Node3D = $Explosion
@onready var left_air_thruster: Node3D = $LeftAirThruster
@onready var right_air_thruster: Node3D = $RightAirThruster

@onready var ship_mesh: Node3D = $ShipMesh
@onready var MainBoosterAudio: AudioStreamPlayer = $MainBooster
@onready var RotationBoosterAudio: AudioStreamPlayer = $RotationBooster


const MASS = 1.0
const ACCELLERATE_VEC = Vector3(0, 0, -20)
const ROTATE_ANGLE = 6
var is_alive = true

func _ready() -> void:
	thruster.disable_thrusters()
	left_air_thruster.disable_airthruster()
	right_air_thruster.disable_airthruster()

func _physics_process(delta: float) -> void:
	if isForLoading:
		left_air_thruster.enable_airthruster()
		right_air_thruster.enable_airthruster()
		thruster.enable_thrusters()
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
					lose()
				else:
					collision.get_collider().explode()
					win()

	else:
		velocity = Vector3(0,0,0)

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
	explosion.explode()

func off_screen():
	Globals.off_screen()
	die()

func lose():
	Globals.lose()
	die()
	
func win():
	Globals.win()
	die()

# BASIC MOVEMENT
#func _physics_process(delta: float) -> void:
	#var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if direction:
		#velocity.x += direction.x * SPEED
		#velocity.z += direction.z * SPEED
#
	#move_and_slide()

func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	off_screen()
