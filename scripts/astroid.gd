extends CharacterBody3D

@export var IS_DANGER = true

@onready var player: CharacterBody3D = $"../Player"

#func _ready() -> void:
	#velocity = (player.position - position) * 10

func _physics_process(delta: float) -> void:
	move_and_slide()
