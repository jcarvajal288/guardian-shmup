extends State

@export var stand_state: State
@export var crouch_state: State


func process_physics(_delta: float) -> State:
	var movement = director.movement_vector * subject.get_speed()
	if movement == Vector2.ZERO:
		return stand_state
	elif movement.y > 0:
		return crouch_state
	movement.y = 0
	subject.flip_sprite(movement.x > 0)
	subject.velocity = movement
	subject.move_and_slide()
	return null
