class_name Director extends Node

var movement_vector = Vector2.ZERO
var action_attack = false
var action_jump = false


func reset() -> void:
	movement_vector = Vector2.ZERO
	action_attack = false
	action_jump = false