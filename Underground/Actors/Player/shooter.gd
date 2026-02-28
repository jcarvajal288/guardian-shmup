extends Node2D

const SHOT_1 = preload("res://Shmup/Actors/PlayerShip/Shot1/Shot1.tscn")

@export var director: Director
var facing = Vector2.LEFT

var fire_rate: float = 0.5


func _process(_delta: float) -> void:
	check_direction()
	if director.action_attack and $Timer.time_left <= 0:
		var shot = SHOT_1.instantiate()
		shot.global_position = $ShotSpawnPoint.global_position
		shot.direction = facing
		Global.add_node_to_level.emit(shot)
		Sounds.play_sound.emit(Sounds.SoundEffect.PLAYER_SHOT, global_position)
		$Timer.start(GameStats.PLAYER_FIRE_RATE)


func check_direction() -> void:
	var gp = $ShotSpawnPoint.position
	if director.movement_vector.x > 0:
		facing = Vector2.RIGHT
		$ShotSpawnPoint.position = Vector2(abs(gp.x), gp.y)
	elif director.movement_vector.x < 0:
		facing = Vector2.LEFT
		$ShotSpawnPoint.position = Vector2(-abs(gp.x) * 1, gp.y)