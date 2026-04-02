class_name LevelScript extends Node

const SPAWN_TOP_LEFT_CORNER = Vector2(-20, -20)
const SPAWN_TOP_LEFT = Vector2(10.0, -20)
const SPAWN_TOP_2_3RDS_LEFT = Vector2(30.0, -20)
const SPAWN_TOP_HALF_LEFT = Vector2(45.0, -20)
const SPAWN_TOP_MIDDLE = Vector2(80, -20)
const SPAWN_TOP_HALF_RIGHT = Vector2(115, -20)
const SPAWN_TOP_2_3RDS_RIGHT = Vector2(126.0, -20)
const SPAWN_TOP_RIGHT = Vector2(150.0, -20)
const SPAWN_TOP_RIGHT_CORNER = Vector2(180, -20)

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

const BIG_SPIDER: PackedScene = preload("res://Actors/BigSpider/BigSpider.tscn")
const EEL: PackedScene = preload("res://Actors/SpaceEel/SpaceEel.tscn")
const SPIDER: PackedScene = preload("res://Actors/Spider/Spider.tscn")


func add_y(v: Vector2, y: float) -> Vector2:
	return Vector2(v.x, v.y + y)


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


func spawn_big_spider(spawn: Vector2, pointA: Vector2, pointB: Vector2) -> Enemy:
	var spider = BIG_SPIDER.instantiate()
	spider.global_position = spawn

	var move_pattern = MovementPatterns.MOVE_BETWEEN_POINTS.instantiate()
	move_pattern.subject = spider
	move_pattern.speed = GameStats.BIG_SPIDER_SPEED
	move_pattern.pointA = pointA
	move_pattern.pointB = pointB
	spider.add_child(move_pattern)
	get_parent().add_child.call_deferred(spider)
	return spider

