extends CharacterBody2D


func _ready() -> void:
	velocity = Vector2(0, 20)


func _process(_delta: float) -> void:
	move_and_slide()
