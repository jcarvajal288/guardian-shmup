extends Node

@export var subject: CharacterBody2D
@export var speed: float
@export var direction: Vector2


func _ready() -> void:
	if direction == Global.TOWARDS_PLAYER:
		direction = (Global.player.global_position - subject.global_position)
	subject.velocity = direction.normalized() * speed


func _physics_process(_delta: float) -> void:
	subject.move_and_slide()


