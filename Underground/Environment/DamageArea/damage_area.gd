extends Area2D

@export var damage: float
@export var tick_rate: float

@onready var is_player_in = false

func _ready() -> void:
	body_entered.connect(start_damage)
	body_exited.connect(end_damage)
	$Timer.timeout.connect(tick_damage)


func start_damage(body: Node2D) -> void:
	if body is Player:
		is_player_in = true
		tick_damage()
		$Timer.start(tick_rate)


func tick_damage() -> void:
	if is_player_in:
		Global.player.take_damage(damage)


func end_damage(body: Node2D) -> void:
	if body is Player:
		is_player_in = false
		$Timer.stop()
