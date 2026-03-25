extends Enemy


func _ready() -> void:
	super()
	$Health.set_health(GameStats.BEETLE_HEALTH)
	$SingleShot.process_mode = Node.PROCESS_MODE_DISABLED
	$MoveToPoint.stopped_moving.connect(start_shooting)
	$MoveToPoint.start_moving()
	

func start_shooting() -> void:
	$AnimationPlayer.play("shooting")
	$SingleShot.process_mode = Node.PROCESS_MODE_INHERIT


func set_movement(destination: Vector2, time: float) -> void:
	$MoveToPoint.destination = destination
	$MoveToPoint.time_to_dest = time


func _on_death() -> void:
	handle_death(
		Effects.EXPLOSION_16x16, 
		Sounds.SoundEffect.SMALL_EXPLOSION_1, 
		GameStats.BEETLE_SCORE
	)
