extends CharacterBody3D

@export var IS_DANGER = true
@onready var player: CharacterBody3D = $"../Player"
@onready var astroidMesh: MeshInstance3D = $MeshInstance3D
@onready var collisionShape: CollisionShape3D = $CollisionShape3D
@onready var explosion: Node3D = $Explosion
@onready var explosionAudio: AudioStreamPlayer = $AsteroidExplosion

func initialize(start_position, player_position):
	look_at_from_position(start_position, player_position, Vector3.UP)
	rotate_y(randf_range(-PI / 4, PI / 4))
	var random_speed = randi_range(0, 100)
	velocity = Vector3.FORWARD * random_speed
	velocity = velocity.rotated(Vector3.UP, rotation.y)

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		if !explosionAudio.playing:
			explosionAudio.play()
		explosion.explode()
		astroidMesh.hide()
		await get_tree().create_timer(1.0).timeout
		queue_free()
