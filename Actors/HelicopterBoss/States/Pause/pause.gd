extends HelicopterState


func enter() -> void:
	$Timer.start(1.0)


func process_frame(_delta: float) -> HelicopterState:
	if $Timer.is_stopped():
		return next_states.pick_random()
	else:
		return null