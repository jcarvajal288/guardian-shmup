extends Enemy


func _ready() -> void:
	super()
	$Eye2x2.z_index = z_index + 1


func _on_death() -> void:
	handle_death(
		Effects.EXPLOSION_32x32, 
		Sounds.SoundEffect.EEL_EXPLOSION, 
		GameStats.SPACE_EEL_SCORE,
	)
