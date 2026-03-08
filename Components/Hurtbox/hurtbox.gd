class_name Hurtbox extends Area2D

signal on_hit(dmg: float)

func register_hit(dmg: float) -> void:
	on_hit.emit(dmg)