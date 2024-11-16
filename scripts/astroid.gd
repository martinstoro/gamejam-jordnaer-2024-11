extends CharacterBody3D

@export var IS_DANGER = true
@onready var player: CharacterBody3D = $"../Player"
@onready var astroidMesh: MeshInstance3D = $MeshInstance3D
@onready var astroidCollision: CollisionShape3D = $CollisionShape3D
@onready var explosion: Node3D = $Explosion

func _ready() -> void:
	var playerPosition = player.position
	velocity = (playerPosition - position).normalized() * randf() * 100
	velocity = velocity.rotated(Vector3.UP, randf())

func _physics_process(delta: float) -> void:
	for index in range(get_slide_collision_count()):
		var collision = get_slide_collision(index)
		if collision.get_collider():
			explosion.explode()
			astroidMesh.hide()
			astroidCollision.disabled = true
			await get_tree().create_timer(2.0).timeout
			queue_free()
	move_and_slide()
