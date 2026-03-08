extends Enemy

func _ready() -> void:
	super()
	$Hitbox.on_hitbox_triggered.connect(_on_death)
	$Hitbox.damage = GameStats.MISSILE_DAMAGE
	$Health.on_death.connect(_on_death)


func _on_death() -> void:
	var explosion = Effects.EXPLOSION_16x16.instantiate()
	explosion.global_position = global_position
	Global.add_node_to_level.emit(explosion)
	Sounds.play_sound.emit(Sounds.SoundEffect.LOW_EXPLOSION, global_position)
	queue_free()