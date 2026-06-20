extends HelicopterState

func enter() -> void:
	super()
	if is_a_above_c():
		set_moves(POS_3, POS_6, POS_9)
	else:
		set_moves(POS_9, POS_6, POS_3)