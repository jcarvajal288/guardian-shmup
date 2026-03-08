extends Node

@export var subject: CharacterBody2D
@export var pointA: Vector2
@export var pointB: Vector2
@export var speed: float

@onready var current_destination = pointA


func _ready() -> void:
	change_direction()


func _physics_process(_delta: float) -> void:
	check_for_direction_change()
	subject.move_and_slide()


func change_direction() -> void:
	var direction = (current_destination - subject.global_position).normalized()
	subject.velocity = direction * speed


func check_for_direction_change() -> void:
	if subject.global_position.distance_squared_to(current_destination) < 2.0:
		if current_destination == pointA:
			current_destination = pointB
		else:
			current_destination = pointA
		change_direction()
		
