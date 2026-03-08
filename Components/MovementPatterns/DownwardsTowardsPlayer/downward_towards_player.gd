extends Node

@export var subject: CharacterBody2D
@export var speed: float
@export var horizontal_accel: float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	subject.velocity = Vector2(0, speed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var acceleration = horizontal_accel * delta
	if Global.player.global_position.x < subject.global_position.x:
		acceleration *= -1
	subject.velocity.x += acceleration
	subject.move_and_slide()
