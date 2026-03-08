class_name Health extends Node

@export var max_health: float
@onready var current_health = max_health

signal health_changed(current_health: float, max_health: float)
signal on_death


func set_health(new_health: float) -> void:
	max_health = new_health
	current_health = max_health


func take_damage(damage: float) -> void:
	current_health -= damage
	if current_health <= 0:
		current_health = 0
		on_death.emit()
	health_changed.emit(current_health, max_health)


func _on_hit(damage: float) -> void:
	take_damage(damage)