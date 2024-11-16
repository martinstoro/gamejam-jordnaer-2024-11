extends StaticBody3D
@onready var player: CharacterBody3D = $"../Player"
@onready var explosion: Node3D = $Explosion
@onready var blue_sphere: MeshInstance3D = $BlueSphere
@onready var sphere: MeshInstance3D = $Sphere

enum {METEOR, PLANET, BLACK_HOLE}

@export var IS_DANGER = true
@export var OBJECT_TYPE = PLANET
@export var GRAVITY_FORCE = 10

func _ready():
	if IS_DANGER != true:
		blue_sphere.visible = true
		sphere.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var mass = scale * scale 
	
	var playerPosition = player.position
	var playerDirection = playerPosition - position
	var playerDistance = playerDirection.length()
	var playerGravity = GRAVITY_FORCE * playerDirection.normalized() * mass / (playerDistance * playerDistance)
	player.velocity -= playerGravity
	
	var astroids = get_tree().get_nodes_in_group("astroids")
	for astroid in astroids:
		var astroidPosition = astroid.position
		var astroidDirection = astroidPosition - position
		var astroidDistance = astroidDirection.length()
		var astroidGravity = GRAVITY_FORCE * astroidDirection.normalized() * mass / (astroidDistance * astroidDistance)
		
		astroid.velocity -= astroidGravity

func explode():
	# spawn explosion effect
	explosion.explode()
	sphere.visible = false
	blue_sphere.visible = false
	await get_tree().create_timer(2.0).timeout
	queue_free()
