extends HelicopterState


func enter() -> void:
	set_moves(POS_1, POS_2, POS_3)


func process_frame(_delta: float) -> HelicopterState:
	var A_done = subjectA.has_stopped_moving
	var B_done = subjectB.has_stopped_moving
	var C_done = subjectC.has_stopped_moving
	if A_done and B_done and C_done:
		return next_states.pick_random()
	return null
