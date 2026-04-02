extends Node

@warning_ignore_start("unused_signal")
signal play_sound(sound_effect: SoundEffect, sound_position: Vector2)
@warning_ignore_restore("unused_signal")

enum SoundEffect {
	BOSS_EXPLOSION_1,
	BOSS_EXPLOSION_2,
	LONG_BOSS_EXPLOSION,
	LOW_EXPLOSION,
	PLAYER_EXPLOSION,
	SMALL_EXPLOSION_1,
	SMALL_EXPLOSION_2,
	EEL_EXPLOSION,

	BOSS_HIT,
	PLAYER_SHIELD,

	PLAYER_SHOT,

	SHIELDS_UP,
}