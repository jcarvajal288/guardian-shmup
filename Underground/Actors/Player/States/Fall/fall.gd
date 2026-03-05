extends State

@export var stand_state: State


func process_physics(delta: float) -> State:
	var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	subject.velocity.y += gravity * delta
	if subject.is_on_floor():
		return stand_state
	subject.velocity.x = director.movement_vector.x * GameStats.PLAYER_WALK_SPEED
	subject.move_and_slide()
	return null