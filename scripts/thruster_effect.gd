extends Node3D
@onready var sparks: GPUParticles3D = $Sparks
@onready var fire: GPUParticles3D = $Fire
@onready var smoke: GPUParticles3D = $Smoke

func enable_thrusters():
	sparks.emitting = true
	fire.emitting = true
	smoke.emitting = true

func disable_thrusters():
	sparks.emitting = false
	fire.emitting = false
	smoke.emitting = false
