extends State

@export var stand_state: State


func process_physics(_delta: float) -> State:
	var movement = director.movement_vector * subject.get_speed()
	if movement == Vector2.ZERO:
		return stand_state
	subject.velocity = movement
	subject.move_and_slide()
	return null
