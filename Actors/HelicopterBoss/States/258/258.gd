extends HelicopterState


func enter() -> void:
	super()
	if is_a_above_c():
		set_moves(POS_2, POS_5, POS_8)
	else:
		set_moves(POS_8, POS_5, POS_2)

