class_name HelicopterState extends Node

const POS_1 = Vector2(16.0, 16.0)
const POS_2 = Vector2(80.0, 16.0)
const POS_3 = Vector2(144.0, 16.0)
const POS_4 = Vector2(16.0, 64.0)
const POS_5 = Vector2(80.0, 64.0)
const POS_6 = Vector2(144.0, 64.0)
const POS_7 = Vector2(16.0, 112.0)
const POS_8 = Vector2(80.0, 112.0)
const POS_9 = Vector2(144.0, 112.0)

const MOVE_TO_POINT = preload("res://Components/MovementPatterns/MoveToPoint/MoveToPoint.tscn")

@export var next_states: Array[HelicopterState] = []
var pause_state: HelicopterState

var subjectA: CharacterBody2D
var subjectB: CharacterBody2D
var subjectC: CharacterBody2D

func enter() -> void:
	pass


func exit() -> void:
	pass


func process_input(_event: InputEvent) -> HelicopterState:
	return null


func process_physics(_delta: float) -> HelicopterState:
	return null


func process_frame(_delta: float) -> HelicopterState:
	var A_done = subjectA.has_stopped_moving
	var B_done = subjectB.has_stopped_moving
	var C_done = subjectC.has_stopped_moving
	if A_done and B_done and C_done:
		if subjectA.is_alive():
			subjectA.fire_pattern.emit()
		if subjectB.is_alive():
			subjectB.fire_pattern.emit()
		if subjectC.is_alive():
			subjectC.fire_pattern.emit()
		pause_state.next_states = next_states
		return pause_state
	return null


func transition_into() -> void:
	pass


func set_moves(pos_a: Vector2, pos_b: Vector2, pos_c: Vector2, time: float = 1.5) -> void:
	var movetoA = MOVE_TO_POINT.instantiate()
	movetoA.subject = subjectA
	movetoA.destination = pos_a
	movetoA.time_to_dest = time
	movetoA.should_decelerate = false
	subjectA.change_movement_pattern(movetoA)

	var movetoB = MOVE_TO_POINT.instantiate()
	movetoB.subject = subjectB
	movetoB.destination = pos_b
	movetoB.time_to_dest = time
	movetoB.should_decelerate = false
	subjectB.change_movement_pattern(movetoB)

	var movetoC = MOVE_TO_POINT.instantiate()
	movetoC.subject = subjectC
	movetoC.destination = pos_c
	movetoC.time_to_dest = time
	movetoC.should_decelerate = false
	subjectC.change_movement_pattern(movetoC)


func is_vertical_pattern() -> bool:
	var x_diff = abs(subjectC.global_position.x - subjectA.global_position.x)
	var y_diff = abs(subjectC.global_position.y - subjectA.global_position.y)
	return x_diff < y_diff


func is_horizontal_pattern() -> bool:
	var x_diff = abs(subjectC.global_position.x - subjectA.global_position.x)
	var y_diff = abs(subjectC.global_position.y - subjectA.global_position.y)
	return y_diff < x_diff


func is_a_left_of_c() -> bool:
	return subjectA.global_position.x < subjectC.global_position.x


func is_a_above_c() -> bool:
	return subjectA.global_position.y < subjectC.global_position.y
