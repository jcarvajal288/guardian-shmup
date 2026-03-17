extends Node

@export var subject: CharacterBody2D
@export var speed: float
@export var turn_rate: float


func _ready() -> void:
	var direction_to_player = (Global.player.global_position - subject.global_position).normalized()
	subject.velocity = direction_to_player * speed


func _physics_process(delta: float) -> void:
	var direction_to_player = (Global.player.global_position - subject.global_position).normalized()
	var turn = subject.velocity.angle_to(direction_to_player) / turn_rate * delta
	var current_direction = subject.velocity.normalized()
	subject.velocity = current_direction.rotated(turn) * speed
	subject.move_and_slide()
