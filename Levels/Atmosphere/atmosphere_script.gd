extends LevelScript

const BEETLE: PackedScene = preload("res://Actors/Beetle/Beetle.tscn")
const BUZZSAW: PackedScene = preload("res://Actors/Buzzsaw/Buzzsaw.tscn")


func _ready() -> void:
	build_level()


func spawn_beetle(starting_point: Vector2, destination: Vector2, time: float) -> void:
	var beetle = BEETLE.instantiate()
	beetle.global_position = starting_point
	beetle.set_movement(destination, time)
	get_parent().add_child.call_deferred(beetle)


func spawn_buzzsaw(starting_point: Vector2) -> void:
	var saw = BUZZSAW.instantiate()
	saw.global_position = starting_point
	get_parent().add_child.call_deferred(saw)


func build_level() -> void:
	await Global.wait_for_sec(1.5)

	spawn_beetle(SPAWN_TOP_2_3RDS_LEFT, add_y(SPAWN_TOP_2_3RDS_LEFT, 40), 1.5)
	await Global.wait_for_sec(0.4)
	spawn_beetle(SPAWN_TOP_2_3RDS_RIGHT, add_y(SPAWN_TOP_2_3RDS_RIGHT, 40), 1.5)
	await Global.wait_for_sec(0.4)
	spawn_beetle(SPAWN_TOP_MIDDLE, add_y(SPAWN_TOP_MIDDLE, 40), 1.5)
	await Global.wait_for_sec(3.0)

	var saws = func():
		spawn_buzzsaw(SPAWN_LEFT_MIDDLE)
		await Global.wait_for_sec(5.0)
		spawn_buzzsaw(SPAWN_RIGHT_MIDDLE)
		await Global.wait_for_sec(5.0)

	var two_column_spiders = func(start_point1, start_point2, direction):
		for i in range(10):
			var starting_point = start_point1
			if i % 2 == 0:	
				starting_point = start_point2
			spawn_spider(starting_point, direction)
			await Global.wait_for_sec(0.2)

	saws.call()
	await Global.wait_for_sec(1.0)
	two_column_spiders.call(SPAWN_TOP_LEFT, SPAWN_TOP_LEFT_CORNER, Vector2(1, 1))
	await Global.wait_for_sec(3.0)
	two_column_spiders.call(SPAWN_TOP_RIGHT, SPAWN_TOP_RIGHT_CORNER, Vector2(-1, 1))
	await Global.wait_for_sec(5.0)

	spawn_eel(SPAWN_TOP_2_3RDS_LEFT)
	spawn_eel(SPAWN_TOP_2_3RDS_RIGHT)
	await Global.wait_for_sec(0.5)
	spawn_eel(SPAWN_TOP_MIDDLE)
	await Global.wait_for_sec(5.0)

	spawn_big_spider(SPAWN_LEFT_HALF_TOP, Vector2(20, 20), Vector2(140, 20))
	await Global.wait_for_sec(2.0)

	two_column_spiders.call(SPAWN_TOP_LEFT, SPAWN_TOP_LEFT_CORNER, Vector2(1, 1))
	await Global.wait_for_sec(3.0)
	two_column_spiders.call(SPAWN_TOP_RIGHT, SPAWN_TOP_RIGHT_CORNER, Vector2(-1, 1))
	await Global.wait_for_sec(5.0)


