extends HelicopterState


func enter() -> void:
	super()
	if is_vertical_pattern():
		if is_a_above_c(): 
			set_moves(POS_1, POS_5, POS_9)
		else:
			set_moves(POS_9, POS_5, POS_1)
	else:
		if is_a_left_of_c(): 
			set_moves(POS_1, POS_5, POS_9)
		else:
			set_moves(POS_9, POS_5, POS_1)