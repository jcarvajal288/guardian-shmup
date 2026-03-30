extends LevelScript


const MISSILE: PackedScene = preload("res://Actors/Missile/Missile.tscn")
const EEL: PackedScene = preload("res://Actors/SpaceEel/SpaceEel.tscn")
const BIG_SPIDER: PackedScene = preload("res://Actors/BigSpider/BigSpider.tscn")
const BOSS: PackedScene = preload("res://Actors/EyeBoss/EyeBoss.tscn")


func _ready() -> void:
	$MissileSpawnTimer.wait_time = 2.0
	$MissileSpawnTimer.timeout.connect(spawn_missile)
	$BossTimer.wait_time = 60.0
	$BossTimer.timeout.connect(spawn_boss)
	build_level()


func spawn_missile() -> void:
	var spawns = [SPAWN_TOP_HALF_LEFT, SPAWN_TOP_MIDDLE, SPAWN_TOP_HALF_RIGHT]
	var spawn = Global.rng.randi_range(0, spawns.size() - 1)
	var missile = MISSILE.instantiate()

	var move_pattern = MovementPatterns.DOWNWARDS_TOWARDS_PLAYER.instantiate()
	move_pattern.subject = missile
	move_pattern.speed = 100.0
	move_pattern.horizontal_accel = 20.0

	missile.global_position = spawns[spawn]
	missile.add_child(move_pattern)
	get_parent().add_child.call_deferred(missile)


func spawn_eel(spawn: Vector2) -> void:
	var eel = EEL.instantiate()
	eel.global_position = spawn
	get_parent().add_child.call_deferred(eel)


func spawn_big_spider(spawn: Vector2, pointA: Vector2, pointB: Vector2) -> void:
	var spider = BIG_SPIDER.instantiate()
	spider.global_position = spawn

	var move_pattern = MovementPatterns.MOVE_BETWEEN_POINTS.instantiate()
	move_pattern.subject = spider
	move_pattern.speed = GameStats.BIG_SPIDER_SPEED
	move_pattern.pointA = pointA
	move_pattern.pointB = pointB
	spider.add_child(move_pattern)
	get_parent().add_child.call_deferred(spider)


func spawn_boss() -> void:
	$MissileSpawnTimer.stop()
	await Global.wait_for_sec(3.0)
	var boss = BOSS.instantiate()
	boss.global_position = Vector2(80, -16)
	get_parent().add_child.call_deferred(boss)


func spawn_spider_line(spawn_position, amount, delay, direction = Global.TOWARDS_PLAYER) -> void:
	for i in amount:
		spawn_spider(spawn_position, direction)
		await Global.wait_for_sec(delay)


func build_level() -> void:
	await Global.wait_for_sec(4.0)
	spawn_spider(SPAWN_LEFT_TOP)
	await Global.wait_for_sec(1.0)
	spawn_spider(SPAWN_RIGHT_TOP)
	await Global.wait_for_sec(1.0)
	spawn_spider(SPAWN_TOP_MIDDLE)
	await Global.wait_for_sec(3.0)

	spawn_spider_line(SPAWN_TOP_LEFT, 2, 0.5)
	spawn_spider_line(SPAWN_TOP_RIGHT, 2, 0.5)
	await Global.wait_for_sec(3.0)
	spawn_spider_line(SPAWN_LEFT_TOP, 2, 0.5)
	spawn_spider_line(SPAWN_RIGHT_TOP, 2, 0.5)
	spawn_eel(SPAWN_TOP_MIDDLE)
	await Global.wait_for_sec(4.0)

	spawn_spider(SPAWN_TOP_LEFT)
	spawn_spider(SPAWN_TOP_RIGHT)
	spawn_spider(SPAWN_LEFT_HALF_BOTTOM)
	spawn_spider(SPAWN_RIGHT_HALF_BOTTOM)
	await Global.wait_for_sec(4.0)

	spawn_eel(SPAWN_TOP_HALF_LEFT)
	spawn_eel(SPAWN_TOP_HALF_RIGHT)
	await Global.wait_for_sec(3.0)
	spawn_spider_line(SPAWN_TOP_LEFT, 5, 0.5, Vector2.DOWN)
	spawn_spider_line(SPAWN_TOP_RIGHT, 5, 0.5, Vector2.DOWN)
	await Global.wait_for_sec(5.0)

	spawn_big_spider(SPAWN_RIGHT_HALF_BOTTOM, Vector2(20, 20), Vector2(140, 20))
	await Global.wait_for_sec(10.0)

	spawn_spider(SPAWN_LEFT_MIDDLE)
	spawn_spider(SPAWN_RIGHT_MIDDLE)
	await Global.wait_for_sec(1.0)
	spawn_spider(SPAWN_LEFT_TOP)
	spawn_spider(SPAWN_RIGHT_TOP)
	await Global.wait_for_sec(1.0)
	spawn_eel(SPAWN_TOP_MIDDLE)
	await Global.wait_for_sec(2.0)

	spawn_spider_line(SPAWN_LEFT_HALF_TOP, 5, 0.5, Vector2.RIGHT)
	spawn_spider_line(SPAWN_RIGHT_HALF_BOTTOM, 5, 0.5, Vector2.LEFT)
	await Global.wait_for_sec(4.0)

	spawn_spider_line(SPAWN_TOP_HALF_LEFT, 5, 0.5, Vector2.DOWN)
	spawn_spider_line(SPAWN_BOTTOM_HALF_RIGHT, 5, 0.5, Vector2.UP)
	await Global.wait_for_sec(4.0)

	var eels = func():
		spawn_eel(SPAWN_TOP_MIDDLE)
		await Global.wait_for_sec(4.0)
		spawn_eel(SPAWN_TOP_MIDDLE)
		await Global.wait_for_sec(4.0)
		spawn_eel(SPAWN_TOP_MIDDLE)

	var spiders = func():
		await Global.wait_for_sec(4.0)
		spawn_spider_line(SPAWN_TOP_HALF_LEFT, 3, 0.5, Vector2.DOWN)
		spawn_spider_line(SPAWN_TOP_HALF_RIGHT, 3, 0.5, Vector2.DOWN)
		await Global.wait_for_sec(4.0)
		spawn_spider_line(SPAWN_TOP_HALF_LEFT, 3, 0.5, Vector2.DOWN)
		spawn_spider_line(SPAWN_TOP_HALF_RIGHT, 3, 0.5, Vector2.DOWN)

	eels.call()
	spiders.call()
