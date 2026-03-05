extends State

@export var fall_state: State

func enter() -> void:
	super()
	subject.velocity.y = -GameStats.PLAYER_JUMP_SPEED


func process_physics(delta: float) -> State:
	var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	subject.velocity.y += gravity * delta
	if subject.velocity.y >= 0:
		return fall_state
	subject.velocity.x = director.movement_vector.x * GameStats.PLAYER_WALK_SPEED
	subject.move_and_slide()
	return null