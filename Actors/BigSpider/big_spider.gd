extends Enemy


func _ready() -> void:
	super()
	$Health.set_health(GameStats.BIG_SPIDER_HEALTH)
	$ShotTimer.timeout.connect(fire)
	$ShotTimer.start(3.0)
	$AnimatedSprite2D.animation_finished.connect(_on_animation_finished)


func _on_death() -> void:
	handle_death(
		Effects.EXPLOSION_32x32, 
		Sounds.SoundEffect.SMALL_EXPLOSION_1, 
		GameStats.BIG_SPIDER_SCORE
	)


func fire() -> void:
	$AnimatedSprite2D.play("fire")


func _on_animation_finished() -> void:
	if $AnimatedSprite2D.animation == 'fire':
		var bullet = Bullets.ENERGY_BULLET.instantiate()
		bullet.direction = Global.TOWARDS_PLAYER
		bullet.speed = 50
		bullet.global_position = $BulletSpawnPoint.global_position
		bullet.damage = GameStats.ENERGY_TURRET_DAMAGE
		Global.add_node_to_level.emit(bullet)
		$AnimatedSprite2D.play("idle")
