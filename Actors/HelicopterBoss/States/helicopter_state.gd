class_name HelicopterState extends Node

const POS_1 = Vector2(16.0, 16.0)
const POS_2 = Vector2(80.0, 16.0)
const POS_3 = Vector2(144.0, 16.0)
const POS_4 = Vector2(16.0, 72.0)
const POS_5 = Vector2(80.0, 72.0)
const POS_6 = Vector2(144.0, 72.0)
const POS_7 = Vector2(16.0, 128.0)
const POS_8 = Vector2(80.0, 128.0)
const POS_9 = Vector2(144.0, 128.0)

const MOVE_TO_POINT = preload("res://Components/MovementPatterns/MoveToPoint/MoveToPoint.tscn")

var subjectA: CharacterBody2D
var subjectB: CharacterBody2D
var subjectC: CharacterBody2D

var signal_state_change


func enter() -> void:
	pass


func exit() -> void:
	pass


func process_input(_event: InputEvent) -> HelicopterState:
	return null


func process_physics(_delta: float) -> HelicopterState:
	return null


func process_frame(_delta: float) -> HelicopterState:
	return null
