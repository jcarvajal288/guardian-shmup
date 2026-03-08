extends Node

@export var subject: CharacterBody2D
@export var speed: float

func _ready() -> void:
	var vector_to_player = (Global.player.global_position - subject.global_position).normalized()
	subject.velocity = vector_to_player * speed


func _physics_process(_delta: float) -> void:
	subject.move_and_slide()

