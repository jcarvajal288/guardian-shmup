class_name LevelScript extends Node

const SPAWN_TOP_LEFT = Vector2(10.0, -20)
const SPAWN_TOP_2_3RDS_LEFT = Vector2(30.0, -20)
const SPAWN_TOP_HALF_LEFT = Vector2(45.0, -20)
const SPAWN_TOP_MIDDLE = Vector2(80, -20)
const SPAWN_TOP_HALF_RIGHT = Vector2(115, -20)
const SPAWN_TOP_2_3RDS_RIGHT = Vector2(126.0, -20)
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


func add_y(v: Vector2, y: float) -> Vector2:
	return Vector2(v.x, v.y + y)