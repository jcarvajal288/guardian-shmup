extends Node2D

const SPAWN_TOP_LEFT = Vector2(10.0, -20)
const SPAWN_TOP_HALF_LEFT = Vector2(45.0, -20)
const SPAWN_TOP_MIDDLE = Vector2(80, -20)
const SPAWN_TOP_HALF_RIGHT = Vector2(115, -20)
const SPAWN_TOP_RIGHT = Vector2(150.0, -20)

const SPAWN_LEFT_TOP = Vector2(-20, 10.0)
const SPAWN_LEFT_HALF_TOP = Vector2(-20, 27.0)
const SPAWN_LEFT_MIDDLE = Vector2(-20, 64.0)
const SPAWN_LEFT_HALF_BOTTOM = Vector2(-20, 86.0)
const SPAWN_LEFT_BOTTOM = Vector2(-20, 108.0)

const SPAWN_RIGHT_TOP = Vector2(180, 10.0)
const SPAWN_RIGHT_HALF_TOP = Vector2(180, 27.0)
const SPAWN_RIGHT_MIDDLE = Vector2(180, 64.0)
const SPAWN_RIGHT_HALF_BOTTOM = Vector2(180, 86.0)
const SPAWN_RIGHT_BOTTOM = Vector2(180, 108.0)

const SPAWN_BOTTOM_LEFT = Vector2(10.0, 148)
const SPAWN_BOTTOM_HALF_LEFT = Vector2(45.0, 148)
const SPAWN_BOTTOM_MIDDLE = Vector2(80, 148)
const SPAWN_BOTTOM_HALF_RIGHT = Vector2(115, 148)
const SPAWN_BOTTOM_RIGHT = Vector2(150.0, 148)

const MISSILE: PackedScene = preload("res://Shmup/Actors/Missile/Missile.tscn")
const SPIDER: PackedScene = preload("res://Shmup/Actors/Spider/Spider.tscn")
const EEL: PackedScene = preload("res://Shmup/Actors/SpaceEel/SpaceEel.tscn")
const BIG_SPIDER: PackedScene = preload("res://Shmup/Actors/BigSpider/BigSpider.tscn")
const BOSS: PackedScene = preload("res://Shmup/Actors/EyeBoss/EyeBoss.tscn")


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


func spawn_spider(spawn: Vector2, direction = Global.TOWARDS_PLAYER) -> void:
	var spider = SPIDER.instantiate()

	var move_pattern = MovementPatterns.MOVE_STRAIGHT.instantiate()
	move_pattern.subject = spider
	move_pattern.direction = direction
	move_pattern.speed = GameStats.SPIDER_SPEED

	var bullet_pattern = BulletPatterns.SINGLE_SHOT.instantiate()
	bullet_pattern.bullet_type = Bullets.BALL_BULLET
	bullet_pattern.speed = 75.0
	bullet_pattern.direction = Global.TOWARDS_PLAYER
	bullet_pattern.startup_time = Global.rng.randf_range(0.5, 1.5)
	bullet_pattern.repeat_time = Global.INFINITE
	bullet_pattern.damage = GameStats.SPIDER_DAMAGE

	spider.global_position = spawn
	spider.add_child(move_pattern)
	spider.add_child(bullet_pattern)
	get_parent().add_child.call_deferred(spider)


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
		await Global.wait_for_sec(5.0)
		spawn_eel(SPAWN_TOP_MIDDLE)
		await Global.wait_for_sec(5.0)
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