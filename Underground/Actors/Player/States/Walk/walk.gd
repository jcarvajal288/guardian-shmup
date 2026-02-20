extends State

@export var stand_state: State
@export var crouch_state: State
@export var jump_state: State
@export var fall_state: State


func process_physics(_delta: float) -> State:
	var movement = director.movement_vector * subject.get_speed()
	if director.action_jump:
		return jump_state
	elif movement == Vector2.ZERO:
		return stand_state
	elif movement.y > 0:
		return crouch_state
	elif not subject.is_on_floor():
		return fall_state
	movement.y = 0
	subject.flip_sprite(movement.x > 0)
	subject.velocity = movement
	subject.move_and_slide()
	return null
