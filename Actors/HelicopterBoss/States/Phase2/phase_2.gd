extends HelicopterState

var boss = null

var positions = [POS_1, POS_2, POS_3, POS_4, POS_5, POS_6]

const TIME_TO_MOVE = 1.0

func enter() -> void:
	if subjectA.is_alive():
		boss = subjectA
	elif subjectB.is_alive():
		boss = subjectB
	else:
		boss = subjectC


func process_frame(_delta: float) -> HelicopterState:
	if boss.has_stopped_moving:
		var new_movement_pattern = MOVE_TO_POINT.instantiate()
		new_movement_pattern.subject = boss
		new_movement_pattern.destination = get_new_position()
		new_movement_pattern.time_to_dest = TIME_TO_MOVE
		new_movement_pattern.should_decelerate = false
		boss.change_movement_pattern(new_movement_pattern)
	return null


func get_new_position() -> Vector2:
	positions.sort_custom(func(a, b):
		return a.distance_to(boss.global_position) < b.distance_to(boss.global_position)
	)
	return positions.slice(1).pick_random()