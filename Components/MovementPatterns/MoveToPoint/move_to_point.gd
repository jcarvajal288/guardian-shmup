extends Node

@export var subject: CharacterBody2D
@export var destination: Vector2
@export var speed: float

signal stopped_moving


func start_moving() -> void:
	var direction = (destination - subject.global_position).normalized()
	subject.velocity = direction * speed


func _physics_process(_delta: float) -> void:
	if subject.global_position.distance_squared_to(destination) > 2.0:
		subject.move_and_slide()
	else:
		subject.velocity = Vector2.ZERO
		stopped_moving.emit()