extends HelicopterState

func enter() -> void:
	super()
	if is_a_left_of_c():
		set_moves(POS_1, POS_2, POS_3)
	else:
		set_moves(POS_3, POS_2, POS_1)