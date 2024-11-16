extends StaticBody3D
@onready var player: CharacterBody3D = $"../Player"

enum {METEOR, PLANET, BLACK_HOLE}

@export var IS_DANGER = true
@export var OBJECT_TYPE = PLANET
@export var GRAVITY_FORCE = 10


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var playerPosition = player.position
	var direction = playerPosition - position
	var distance = direction.length()
	var mass = scale * scale 
	
	var gravity = GRAVITY_FORCE * direction.normalized() * mass / (distance * distance)
	
	player.velocity -= gravity
	
