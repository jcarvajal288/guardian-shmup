extends Node


func _ready() -> void:
	Sounds.play_sound.connect(_on_play_sound)


func play_sound_at_position(sound_player: AudioStreamPlayer2D, sound_position: Vector2) -> void:
	sound_player.global_position = sound_position
	sound_player.play()

	
func _on_play_sound(sound_effect: Sounds.SoundEffect, sound_position: Vector2) -> void:
	if sound_effect == Sounds.SoundEffect.BOSS_EXPLOSION_1:
		play_sound_at_position($Explosions/BossExplosion1, sound_position)
	elif sound_effect == Sounds.SoundEffect.BOSS_EXPLOSION_2:
		play_sound_at_position($Explosions/BossExplosion2, sound_position)
	elif sound_effect == Sounds.SoundEffect.LONG_BOSS_EXPLOSION:
		play_sound_at_position($Explosions/LongBossExplosion, sound_position)
	elif sound_effect == Sounds.SoundEffect.LOW_EXPLOSION:
		play_sound_at_position($Explosions/LowExplosion, sound_position)
	elif sound_effect == Sounds.SoundEffect.PLAYER_EXPLOSION:
		play_sound_at_position($Explosions/PlayerExplosion, sound_position)
	elif sound_effect == Sounds.SoundEffect.PLAYER_EXPLOSION:
		play_sound_at_position($Explosions/PlayerExplosion, sound_position)
	elif sound_effect == Sounds.SoundEffect.SMALL_EXPLOSION_1:
		play_sound_at_position($Explosions/SmallExplosion1, sound_position)
	elif sound_effect == Sounds.SoundEffect.SMALL_EXPLOSION_2:
		play_sound_at_position($Explosions/SmallExplosion2, sound_position)
	elif sound_effect == Sounds.SoundEffect.EEL_EXPLOSION:
		play_sound_at_position($Explosions/EelExplosion, sound_position)
	elif sound_effect == Sounds.SoundEffect.BOSS_HIT:
		play_sound_at_position($Hits/BossHit, sound_position)
	elif sound_effect == Sounds.SoundEffect.PLAYER_SHIELD:
		play_sound_at_position($Hits/PlayerShield, sound_position)
	elif sound_effect == Sounds.SoundEffect.PLAYER_SHOT:
		play_sound_at_position($Shots/PlayerShot, sound_position)
	elif sound_effect == Sounds.SoundEffect.SHIELDS_UP:
		play_sound_at_position($Pickups/ShieldsUp, sound_position)
