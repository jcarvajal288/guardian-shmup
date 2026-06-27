extends CharacterBody2D

var movement_pattern: Node = null
var bullet_pattern: Node = null

var has_stopped_moving: bool = false

signal fire_pattern


func _ready() -> void:
	$Hurtbox.on_hit.connect($Health.take_damage)
	$Health.on_death.connect(_on_death)
	fire_pattern.connect(fire)


func change_movement_pattern(new_pattern: Node) -> void:
	if movement_pattern != null:
		movement_pattern.queue_free()
	movement_pattern = new_pattern
	add_child(movement_pattern)
	movement_pattern.start_moving()
	has_stopped_moving = false
	movement_pattern.stopped_moving.connect(_on_stopped_moving)


func _on_stopped_moving() -> void:
	has_stopped_moving = true


func _on_death() -> void:
	$Sprite2D.visible = false
	$Hurtbox.set_deferred("monitoring", false)
	$Hurtbox.set_deferred("monitorable", false)
	$Hitbox.set_deferred("monitoring", false)
	$Hitbox.set_deferred("monitorable", false)

	var vfx = Effects.EXPLOSION_32x32.instantiate()
	vfx.global_position = global_position
	Global.add_node_to_level.emit(vfx)
	var sfx = Sounds.SoundEffect.LOW_EXPLOSION
	Sounds.play_sound.emit(sfx, global_position)


func is_alive() -> bool:
	return $Sprite2D.visible


func fire() -> void:
	if bullet_pattern:
		bullet_pattern.queue_free()
	var pattern = BulletPatterns.FIRE_LINE.instantiate()
	pattern.bullet_type = Bullets.BALL_BULLET
	pattern.speed = 100
	pattern.startup_time = 0.01
	pattern.repeat_time = 0.05
	pattern.num_bullets = 5	
	add_child(pattern)
	bullet_pattern = pattern
