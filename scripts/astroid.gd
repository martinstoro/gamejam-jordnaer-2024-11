extends CharacterBody3D

@export var IS_DANGER = true
@onready var player: CharacterBody3D = $"../Player"
@onready var astroidMesh: MeshInstance3D = $MeshInstance3D
@onready var explosion: Node3D = $Explosion
@onready var explosionAudio: AudioStreamPlayer = $AsteroidExplosion

var is_dead: bool = false

func _ready() -> void:
	var playerPosition = player.position
	velocity = (playerPosition - position).normalized() * randf() * 100
	velocity = velocity.rotated(Vector3.UP, randf())

func _physics_process(delta: float) -> void:
	for index in range(get_slide_collision_count()):
		var collision = get_slide_collision(index)
		if collision.get_collider() and !is_dead:
			is_dead = true
			if !explosionAudio.playing:
				explosionAudio.play()
			explosion.explode()
			astroidMesh.hide()
			await get_tree().create_timer(2.0).timeout
			queue_free()
			break
	move_and_slide()
