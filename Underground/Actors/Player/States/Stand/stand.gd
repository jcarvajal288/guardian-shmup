extends State

@export var walk_state: State
@export var crouch_state: State
@export var jump_state: State

func enter() -> void:
	super()
	subject.velocity = Vector2.ZERO


func process_frame(_delta: float) -> State:
	subject.global_position = Vector2(
		snapped(subject.global_position.x, 1.0),
		snapped(subject.global_position.y, 1.0)
	)
	if director.action_jump:
		return jump_state
	elif director.movement_vector.x != 0:
		return walk_state
	elif director.movement_vector.y > 0:
		return crouch_state
	return null