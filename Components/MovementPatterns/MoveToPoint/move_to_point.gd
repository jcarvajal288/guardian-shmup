extends Node

@export var subject: CharacterBody2D
@export var destination: Vector2
@export var time_to_dest: float

signal stopped_moving

var deceleration: float
var elapsed_time: float = 0.0


func start_moving() -> void:
	var diff = destination - subject.global_position
	var distance = diff.length()
	var direction = diff.normalized()

	var initial_speed = (2.0 * distance) / time_to_dest
	deceleration = initial_speed / time_to_dest	
	subject.velocity = direction * initial_speed


func _physics_process(delta: float) -> void:
	if subject.velocity == Vector2.ZERO:
		return
	elif elapsed_time < time_to_dest:
		elapsed_time += delta
		var current_speed = subject.velocity.length()
		var new_speed = max(0, current_speed - (deceleration * delta))
		if current_speed > 0:
			subject.velocity = subject.velocity.normalized() * new_speed
			if subject.velocity == Vector2.ZERO:
				stopped_moving.emit()
		subject.move_and_slide()
