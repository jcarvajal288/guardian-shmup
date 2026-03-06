extends Node2D

const SHOT_1 = preload("res://Shmup/Actors/PlayerShip/Shot1/Shot1.tscn")

@export var director: Director

var fire_rate: float = 0.5

var shot_direction = "Left"

@onready var shot_points = {
	"Left": [$ShotSpawnPointLeft, Vector2.LEFT],
	"UpLeft": [$ShotSpawnPointUpLeft, (Vector2.LEFT + Vector2.UP).normalized()],
	"Up": [$ShotSpawnPointUp, Vector2.UP],
	"UpRight": [$ShotSpawnPointUpRight, (Vector2.RIGHT + Vector2.UP).normalized()],
	"Right": [$ShotSpawnPointRight, Vector2.RIGHT],
	"DownRight": [$ShotSpawnPointDownRight, (Vector2.RIGHT + Vector2.DOWN).normalized()],
	"Down": [$ShotSpawnPointDown, Vector2.DOWN],
	"DownLeft": [$ShotSpawnPointDownLeft, (Vector2.LEFT + Vector2.DOWN).normalized()],
	"CrouchLeft": [$ShotSpawnPointCrouchLeft, Vector2.LEFT],
	"CrouchRight": [$ShotSpawnPointCrouchRight, Vector2.RIGHT],
}


func _process(_delta: float) -> void:
	if director.action_attack and $Timer.time_left <= 0:
		var shot = SHOT_1.instantiate()
		shot.global_position = shot_points[shot_direction][0].global_position
		shot.direction = shot_points[shot_direction][1]
		Global.add_node_to_level.emit(shot)
		Sounds.play_sound.emit(Sounds.SoundEffect.PLAYER_SHOT, global_position)
		$Timer.start(GameStats.PLAYER_FIRE_RATE)