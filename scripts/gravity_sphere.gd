extends StaticBody3D
@onready var player: CharacterBody3D = $"../Player"

@export var IS_DANGER = true
const GRAVITY_FORCE = 0.5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var playerPosition = player.position
	var direction = playerPosition - position
	player.velocity -= direction.normalized() * scale*scale / direction.length() * GRAVITY_FORCE
	
