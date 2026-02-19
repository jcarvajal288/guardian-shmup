extends State

@export var walk_state: State

func enter() -> void:
	super()
	subject.velocity = Vector2.ZERO


func process_frame(_delta: float) -> State:
	subject.global_position = Vector2(
		snapped(subject.global_position.x, 1.0),
		snapped(subject.global_position.y, 1.0)
	)
	if director.movement_vector.x != 0:
		return walk_state
	return null