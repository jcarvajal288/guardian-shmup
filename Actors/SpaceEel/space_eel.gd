extends Enemy


func _ready() -> void:
	super()
	$Eye2x2.z_index = z_index + 1
	$Health.on_death.connect(_on_death)


func _on_death() -> void:
	var explosion = Effects.EXPLOSION_32x32.instantiate()
	explosion.global_position = global_position
	Global.add_node_to_level.emit(explosion)
	Sounds.play_sound.emit(Sounds.SoundEffect.EEL_EXPLOSION, global_position)
	queue_free()
