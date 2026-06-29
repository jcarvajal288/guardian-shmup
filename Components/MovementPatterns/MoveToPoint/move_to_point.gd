extends Node

@export var subject: CharacterBody2D
@export var destination: Vector2
@export var time_to_dest: float
@export var should_decelerate: bool

signal stopped_moving

var deceleration: float
var elapsed_time: float = 0.0


func start_moving() -> void:
	var diff = destination - subject.global_position
	var distance = diff.length()
	var direction = diff.normalized()

	if should_decelerate:
		var initial_speed = (2.0 * distance) / time_to_dest
		deceleration = initial_speed / time_to_dest	
		subject.velocity = direction * initial_speed
	else:
		var speed = distance / time_to_dest
		subject.velocity = speed * direction


func _physics_process(delta: float) -> void:
	if should_decelerate:
		if subject.velocity == Vector2.ZERO:
			stopped_moving.emit()
			return
		elif elapsed_time < time_to_dest:
			if should_decelerate:
				elapsed_time += delta
				var current_speed = subject.velocity.length()
				var new_speed = max(0, current_speed - (deceleration * delta))
				if current_speed > 0:
					subject.velocity = subject.velocity.normalized() * new_speed
				subject.move_and_slide()
	else:
		if elapsed_time >= time_to_dest:
			subject.velocity = Vector2.ZERO
			stopped_moving.emit()
			return
		else:
			elapsed_time += delta
			subject.move_and_slide()

