extends Node2D

const MISSILE: PackedScene = preload("res://Actors/Missile/Missile.tscn")


func _ready() -> void:
	$LaunchTimer.timeout.connect(launch_missile)


func launch_missile() -> void:
	var missile = MISSILE.instantiate()

	var move_pattern = MovementPatterns.DOWNWARDS_TOWARDS_PLAYER.instantiate()
	move_pattern.subject = missile
	move_pattern.speed = 100.0
	move_pattern.horizontal_accel = 20.0

	missile.global_position = global_position
	missile.add_child(move_pattern)
	Global.add_node_to_level.emit(missile)
