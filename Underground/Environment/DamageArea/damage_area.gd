extends Area2D

@export var damage: float
@export var tick_rate: float

@onready var is_player_in = false

func _ready() -> void:
	body_entered.connect(start_damage)


func start_damage(body: Node2D) -> void:
	if body is Player:
		is_player_in = true
		body.take_damage(damage)
