extends HelicopterState


func enter() -> void:
	super()
	$Timer.start(1.0)


func process_frame(_delta: float) -> HelicopterState:
	if $Timer.time_left <= 0.0:
		return next_states.pick_random()
	else:
		return null