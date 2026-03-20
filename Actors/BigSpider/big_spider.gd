extends Enemy


func _ready() -> void:
	super()
	$Hurtbox.on_hit.connect(_on_hit)
	$Health.set_health(GameStats.BIG_SPIDER_HEALTH)
	$ShotTimer.timeout.connect(fire)
	$ShotTimer.start(3.0)
	$AnimatedSprite2D.animation_finished.connect(_on_animation_finished)


func _on_hit(_dmg: float) -> void:
	var hit = Effects.EXPLOSION_8x8_2.instantiate()
	var size = $CollisionShape2D.shape.radius
	var x = Global.rng.randf_range(-size / 2, size / 2)
	var y = Global.rng.randf_range(-size / 2, size / 2)
	hit.global_position = global_position + Vector2(x, y)
	Global.add_node_to_level.emit(hit)


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
