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


func play_animation(animation_name: String) -> void:
	$UpperAnimationPlayer.play("RESET")
	$UpperAnimationPlayer.advance(0)
	$UpperAnimationPlayer.play(animation_name)

	$LegAnimationPlayer.play("RESET")
	$LegAnimationPlayer.advance(0)
	$LegAnimationPlayer.play(animation_name)
