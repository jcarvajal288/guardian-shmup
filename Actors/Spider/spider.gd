extends Enemy


func _ready() -> void:
	super()
	$Health.on_death.connect(_on_death)


func _on_death() -> void:
	var explosion = Effects.EXPLOSION_8x8.instantiate()
	explosion.global_position = global_position
	Global.add_node_to_level.emit(explosion)
	Sounds.play_sound.emit(Sounds.SoundEffect.SMALL_EXPLOSION_1, global_position)
	queue_free()
