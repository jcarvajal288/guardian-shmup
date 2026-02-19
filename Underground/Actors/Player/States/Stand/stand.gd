extends State

@export var walk_state: State

func enter() -> void:
	super()
	subject.velocity = Vector2.ZERO


func process_frame(_delta: float) -> State:
	if director.movement_vector.x != 0:
		return walk_state
	return null