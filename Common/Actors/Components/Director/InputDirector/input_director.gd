extends Director

func bind_8_way(input_direction: Vector2) -> Vector2:
	return Vector2(
		snapped(input_direction.x, 0.5),
		snapped(input_direction.y, 0.5)
	).normalized()


func _physics_process(_delta: float) -> void:
	movement_vector = bind_8_way(Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down"))
	action_jump = Input.is_action_pressed("jump")
	action_attack = Input.is_action_pressed("shoot")