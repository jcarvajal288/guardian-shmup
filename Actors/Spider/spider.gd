extends Enemy


func _on_death() -> void:
	handle_death(
		Effects.EXPLOSION_8x8, 
		Sounds.SoundEffect.SMALL_EXPLOSION_1, 
		GameStats.SPIDER_SCORE
	)