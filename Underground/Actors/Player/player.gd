class_name Player extends CharacterBody2D


func _ready() -> void:
	$StateMachine.init(self)
	Global.player = self
	z_index = Global.RenderOrder.PLAYER
	$Health.set_health(GameStats.PLAYER_STARTING_HEALTH)
	Global.player_health_changed.emit($Health.current_health, $Health.max_health)


func get_speed() -> float:
	return GameStats.PLAYER_WALK_SPEED


func take_damage(damage: float) -> void:
	$Health.take_damage(damage)
	Global.player_health_changed.emit($Health.current_health, $Health.max_health)


func flip_sprite(is_flipped: bool) -> void:
	$UpperSprite.flip_h = is_flipped
	$LegSprite.flip_h = is_flipped


func _unhandled_input(event: InputEvent) -> void:
	$StateMachine.process_input(event)


func _physics_process(delta: float) -> void:
	$StateMachine.process_physics(delta)


func _process(delta: float) -> void:
	$StateMachine.process_frame(delta)
	manage_upper_sprite()
	flip_sprite($InputDirector.movement_vector.x > 0)


func play_animation(animation_name: String) -> void:
	$LegAnimationPlayer.play("RESET")
	$LegAnimationPlayer.advance(0)
	$LegAnimationPlayer.play(animation_name)


func manage_upper_sprite() -> void:
	var move_vector = $InputDirector.movement_vector
	$UpperAnimationPlayer.play("RESET")
	$UpperAnimationPlayer.advance(0)
	if is_on_floor() and move_vector.y > 0.0:
		$UpperAnimationPlayer.play("crouching")
	elif move_vector.y < 0.0 and move_vector.x == 0.0:
		$UpperAnimationPlayer.play("point_up")
	elif move_vector.y < 0.0 and move_vector.x != 0.0:
		$UpperAnimationPlayer.play("point_up_diagonal")
	elif move_vector.y > 0.0 and move_vector.x != 0.0:
		$UpperAnimationPlayer.play("point_down_diagonal")
	elif move_vector.y > 0.0 and move_vector.x == 0.0:
		$UpperAnimationPlayer.play("point_down")
	else:
		$UpperAnimationPlayer.play("point_side")