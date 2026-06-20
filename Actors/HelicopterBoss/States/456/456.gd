extends HelicopterState

func enter() -> void:
	super()
	if is_a_left_of_c():
		set_moves(POS_4, POS_5, POS_6)
	else:
		set_moves(POS_6, POS_5, POS_4)