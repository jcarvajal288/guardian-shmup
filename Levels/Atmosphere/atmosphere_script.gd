extends LevelScript

const BEETLE: PackedScene = preload("res://Actors/Beetle/Beetle.tscn")


func _ready() -> void:
	build_level()


func spawn_beetle(starting_point: Vector2, destination: Vector2, time: float) -> void:
	var beetle = BEETLE.instantiate()
	beetle.global_position = starting_point
	beetle.set_movement(destination, time)
	get_parent().add_child.call_deferred(beetle)


func build_level() -> void:
	await Global.wait_for_sec(1.5)
	spawn_beetle(SPAWN_TOP_2_3RDS_LEFT, add_y(SPAWN_TOP_2_3RDS_LEFT, 40), 1.5)
	await Global.wait_for_sec(0.4)
	spawn_beetle(SPAWN_TOP_2_3RDS_RIGHT, add_y(SPAWN_TOP_2_3RDS_RIGHT, 40), 1.5)
	await Global.wait_for_sec(0.4)
	spawn_beetle(SPAWN_TOP_MIDDLE, add_y(SPAWN_TOP_MIDDLE, 40), 1.5)
