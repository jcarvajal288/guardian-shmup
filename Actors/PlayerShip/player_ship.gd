class_name PlayerShip extends CharacterBody2D

const SHOT_1 = preload("res://Actors/PlayerShip/Shot1/Shot1.tscn")

const SPEED = GameStats.PLAYER_SHIP_SPEED

var can_shoot = true


func _ready() -> void:
	Global.player = self
	z_index = Global.RenderOrder.PLAYER
	$ShotTimer.timeout.connect(expire_shot_cooldown)
	$Hurtbox.on_hit.connect(_on_hit)
	$Health.set_health(GameStats.PLAYER_STARTING_HEALTH)
	$Health.on_death.connect(_on_death)
	Global.player_health_changed.emit($Health.current_health, $Health.max_health)


func expire_shot_cooldown() -> void:
	can_shoot = true


func _physics_process(_delta: float) -> void:
	move()
	shoot()
	animate()


func get_movement_vector() -> Vector2:
	var mv = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var snapped_vector = Vector2(
		snapped(mv.x, 0.5), 
		snapped(mv.y, 0.5)
	).normalized()
	return snapped_vector


func move() -> void:
	var movement_vector = get_movement_vector()
	velocity = movement_vector * SPEED
	global_position = Vector2(
		snapped(global_position.x, 1.0),
		snapped(global_position.y, 1.0)
	)
	move_and_slide()


func shoot() -> void:
	if can_shoot and Input.is_action_pressed("shoot"):
		var shot = SHOT_1.instantiate()
		shot.global_position = global_position
		shot.global_position.y -= 8.0
		Global.add_node_to_level.emit(shot)
		Sounds.play_sound.emit(Sounds.SoundEffect.PLAYER_SHOT, global_position)
		can_shoot = false
		$ShotTimer.start(GameStats.PLAYER_FIRE_RATE)


func animate() -> void:
	var movement_vector = get_movement_vector()
	if movement_vector.x != 0:
		$Sprite2D.frame = 1
	else:
		$Sprite2D.frame = 0
	$Sprite2D.flip_h = movement_vector.x < 0


func _on_hit(damage: float) -> void:
	$Hurtbox.set_deferred("monitoring", false)
	$Hurtbox.set_deferred("monitorable", false)
	$Shield.visible = true
	$Sprite2D.modulate.a = 0.5

	$Health._on_hit(damage)
	Global.player_health_changed.emit($Health.current_health, $Health.max_health)
	Sounds.play_sound.emit(Sounds.SoundEffect.PLAYER_SHIELD, global_position)

	await get_tree().create_timer(GameStats.PLAYER_HIT_INVULN_IN_SECS).timeout

	$Hurtbox.set_deferred("monitoring", true)
	$Hurtbox.set_deferred("monitorable", true)
	$Shield.visible = false
	$Sprite2D.modulate.a = 1.0


func _on_death() -> void:
	$DeathExplosion.start()
	Sounds.play_sound.emit(Sounds.SoundEffect.PLAYER_EXPLOSION, global_position)


func add_shield(amount: float) -> void:
	$Health.current_health += amount
	if $Health.current_health > $Health.max_health:
		$Health.max_health = $Health.current_health
	Global.player_health_changed.emit($Health.current_health, $Health.max_health)