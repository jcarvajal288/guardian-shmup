extends Enemy

var bounce_time = 0.4
var bounce_speed = 80.0

func _ready() -> void:
	super()
	$Health.on_death.connect(_on_death)
	$Hitbox.on_hitbox_triggered.connect(bounce)
	$BounceTimer.timeout.connect(stop_bouncing)


func _on_death() -> void:
	var explosion = Effects.EXPLOSION_16x16.instantiate()
	explosion.global_position = global_position
	Global.add_node_to_level.emit(explosion)
	Sounds.play_sound.emit(Sounds.SoundEffect.LOW_EXPLOSION, global_position)
	queue_free()


func _physics_process(_delta: float) -> void:
	if not $BounceTimer.is_stopped():
		move_and_slide()


func bounce() -> void:
	$ChasePlayer.process_mode = Node.PROCESS_MODE_DISABLED
	var direction_to_player = (Global.player.global_position - global_position).normalized()
	var away_from_player = Vector2(-direction_to_player.x, -direction_to_player.y)
	velocity = bounce_speed * away_from_player
	$BounceTimer.start(bounce_time)


func stop_bouncing() -> void:
	$ChasePlayer.process_mode = Node.PROCESS_MODE_INHERIT