extends Node2D

const DUMMY_PLAYER = preload("res://Actors/PlayerShip/DummyPlayer.tscn")

func start() -> void:
	var explosion_field = Effects.EXPLOSION_FIELD.instantiate()
	explosion_field.dimensions = Vector2(16, 16)
	explosion_field.num_wave = 2
	explosion_field.wave_delay = 0.1
	add_child(explosion_field)

	await Global.wait_for_sec(0.5)

	var explosion = Effects.EXPLOSION_16x16.instantiate()
	explosion.global_position = global_position
	Global.add_node_to_level.emit(explosion)
	var dummy_player = DUMMY_PLAYER.instantiate()
	dummy_player.global_position = Global.player.global_position
	Global.player = dummy_player
	Global.game_over.emit()
	get_parent().queue_free()
