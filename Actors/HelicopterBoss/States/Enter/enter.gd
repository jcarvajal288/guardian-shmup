extends HelicopterState


func enter() -> void:
	var movetoA = MOVE_TO_POINT.instantiate()
	movetoA.subject = subjectA
	movetoA.destination = POS_1
	movetoA.time_to_dest = 5.0
	subjectA.change_movement_pattern(movetoA)

	var movetoB = MOVE_TO_POINT.instantiate()
	movetoB.subject = subjectB
	movetoB.destination = POS_2
	movetoB.time_to_dest = 5.0
	subjectB.change_movement_pattern(movetoB)

	var movetoC = MOVE_TO_POINT.instantiate()
	movetoC.subject = subjectC
	movetoC.destination = POS_3
	movetoC.time_to_dest = 5.0
	subjectC.change_movement_pattern(movetoC)


func process_frame(_delta: float) -> HelicopterState:
	var A_done = subjectA.has_stopped_moving
	var B_done = subjectB.has_stopped_moving
	var C_done = subjectC.has_stopped_moving
	if A_done and B_done and C_done:
		print("enter complete") 
	return null
