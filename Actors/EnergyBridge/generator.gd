extends Enemy

signal generator_died()


func _on_death() -> void:
	handle_death(
		Effects.EXPLOSION_16x16, 
		Sounds.SoundEffect.SMALL_EXPLOSION_1, 
		GameStats.TANK_SCORE
	)
	generator_died.emit()


func deactivate() -> void:
	$AnimatedSprite2D.play("deactivated")