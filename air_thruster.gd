extends Node3D
@onready var air: GPUParticles3D = $Air

func enable_airthruster():
	air.emitting = true

func disable_airthruster():
	air.emitting = false
