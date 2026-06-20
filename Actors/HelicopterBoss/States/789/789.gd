extends HelicopterState

func enter() -> void:
	super()
	if is_a_left_of_c():
		set_moves(POS_7, POS_8, POS_9)
	else:
		set_moves(POS_9, POS_8, POS_7)