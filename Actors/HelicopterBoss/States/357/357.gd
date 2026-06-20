extends HelicopterState

func enter() -> void:
	super()
	if is_vertical_pattern():
		if is_a_above_c(): 
			set_moves(POS_3, POS_5, POS_7)
		else:
			set_moves(POS_7, POS_5, POS_3)
	else:
		if is_a_left_of_c(): 
			set_moves(POS_7, POS_5, POS_3)
		else:
			set_moves(POS_3, POS_5, POS_7)