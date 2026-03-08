extends Node2D


func _ready() -> void:
	$Hurtbox.on_hit.connect(_on_hit)
	$ShotTimer.timeout.connect(open_turret)
	$AnimationPlayer.animation_finished.connect(_on_animation_finished)
	$Health.on_death.connect(_on_death)
	set_shot_timer()


func set_shot_timer() -> void:
	var time = Global.rng.randf_range(3.0, 6.0)
	$ShotTimer.start(time)


func open_turret() -> void:
	$AnimationPlayer.play('fire')


func _on_animation_finished(anim_name: String) -> void:
	if anim_name == 'fire':
		fire()
		$AnimationPlayer.play('close')
	elif anim_name == 'close':
		set_shot_timer()


func fire() -> void:
	var bullet = Bullets.ENERGY_BULLET.instantiate()
	bullet.direction = Global.TOWARDS_PLAYER
	bullet.speed = 50
	bullet.global_position = global_position
	bullet.damage = GameStats.ENERGY_TURRET_DAMAGE
	Global.add_node_to_level.emit(bullet)


func _on_hit(dmg: float) -> void:
	$Health.take_damage(dmg)
	var hit = Effects.EXPLOSION_8x8_2.instantiate()
	var size = $Sprite2D.get_rect().size
	var x = Global.rng.randf_range(-size.x / 2, size.x / 2)
	var y = Global.rng.randf_range(-size.y / 2, size.y / 2)
	hit.global_position = global_position + Vector2(x, y)
	Global.add_node_to_level.emit(hit)


func _on_death() -> void:
	var explosion = Effects.EXPLOSION_8x8.instantiate()
	explosion.global_position = global_position
	Global.add_node_to_level.emit(explosion)
	Sounds.play_sound.emit(Sounds.SoundEffect.SMALL_EXPLOSION_1, global_position)
	queue_free()