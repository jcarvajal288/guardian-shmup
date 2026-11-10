extends Enemy

# func _on_hit(_dmg: float) -> void:
# 	if $Health.max_health > 1:
# 		var hit = Effects.EXPLOSION_8x8_2.instantiate()
# 		var size = $CollisionShape2D.shape.radius
# 		var x = Global.rng.randf_range(-size / 2, size / 2)
# 		var y = Global.rng.randf_range(-size / 2, size / 2)
# 		hit.global_position = $CollisionShape2D.global_position + Vector2(x, y)
# 		print(global_position)
# 		Global.add_node_to_level.emit(hit)

func _on_death() -> void:
	handle_death(
		Effects.EXPLOSION_16x16, 
		Sounds.SoundEffect.SMALL_EXPLOSION_1, 
		GameStats.TANK_SCORE
	)