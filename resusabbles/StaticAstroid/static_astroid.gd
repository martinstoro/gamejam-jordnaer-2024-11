extends AnimatableBody3D
@export var IS_DANGER = true

var rotationSpeed = 0.01
var rotationVelocityX
var rotationVelocityY
var rotationVelocityZ

func _ready():
	rotationVelocityX = randf() * rotationSpeed
	rotationVelocityY = randf() * rotationSpeed
	rotationVelocityZ = randf() * rotationSpeed
	
func _physics_process(delta: float) -> void:
	rotation.x += rotationVelocityX
	rotation.y += rotationVelocityY
	rotation.z += rotationVelocityZ
