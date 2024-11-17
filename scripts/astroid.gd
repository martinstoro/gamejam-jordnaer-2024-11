extends CharacterBody3D

@export var IS_DANGER = true
@onready var player: CharacterBody3D = $"../Player"
@onready var astroidMesh: MeshInstance3D = $MeshInstance3D
@onready var collisionShape: CollisionShape3D = $CollisionShape3D
@onready var explosion: Node3D = $Explosion
@onready var explosionAudio: AudioStreamPlayer = $AsteroidExplosion

var rotationSpeed = 0.01
var rotationVelocityX
var rotationVelocityY
var rotationVelocityZ

func initialize(start_position, player_position):
	look_at_from_position(start_position, player_position, Vector3.UP)
	rotate_y(randf_range(-PI / 4, PI / 4))
	var random_speed = randi_range(0, 100)
	velocity = Vector3.FORWARD * random_speed
	velocity = velocity.rotated(Vector3.UP, rotation.y)
	rotationVelocityX = randf() * rotationSpeed
	rotationVelocityY = randf() * rotationSpeed
	rotationVelocityZ = randf() * rotationSpeed
	var random_size := randf_range(0.5,2)
	scale = Vector3(random_size,random_size,random_size)

func _physics_process(delta: float) -> void:
	rotation.x += rotationVelocityX
	rotation.y += rotationVelocityY
	rotation.z += rotationVelocityZ
	var collision = move_and_collide(velocity * delta)
	if collision:
		if !explosionAudio.playing:
			explosionAudio.play()
		explosion.explode()
		astroidMesh.hide()
		await get_tree().create_timer(1.0).timeout
		queue_free()

func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	queue_free()
