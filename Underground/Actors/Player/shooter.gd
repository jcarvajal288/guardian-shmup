extends Marker2D

const SHOT_1 = preload("res://Shmup/Actors/PlayerShip/Shot1/Shot1.tscn")

@export var director: Director

var fire_rate: float = 0.5


func _process(_delta: float) -> void:
	if director.action_attack and $Timer.time_left <= 0:
		var shot = SHOT_1.instantiate()
		shot.global_position = global_position
		Global.add_node_to_level.emit(shot)
		Sounds.play_sound.emit(Sounds.SoundEffect.PLAYER_SHOT, global_position)
		$Timer.start(GameStats.PLAYER_FIRE_RATE)
