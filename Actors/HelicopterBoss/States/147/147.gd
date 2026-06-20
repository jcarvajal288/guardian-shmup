extends HelicopterState


func enter() -> void:
	super()
	if is_a_above_c():
		set_moves(POS_1, POS_4, POS_7)
	else:
		set_moves(POS_7, POS_4, POS_1)