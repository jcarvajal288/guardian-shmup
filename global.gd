extends Node

@onready var rng = RandomNumberGenerator.new()

const INFINITE = 999999999999

const TOWARDS_PLAYER = Vector2.ZERO

var player: CharacterBody2D = null

enum CollisionLayer {
	PLAYER = 1,
	ENEMY = 2,
	BULLET = 3,
	SHOT = 4,
	PLAYER_HITBOX = 5,
}

enum RenderOrder {
	PLAYER = 5,
	SHOT = 1,
	ENEMY = 9,
	BULLET = 10,
	TOP = 20,
}

@warning_ignore_start("unused_signal")
signal game_over
signal player_health_changed
signal reset
signal bind_camera(rect: Rect2)
signal add_node_to_level(node: Node2D)
signal transition_room(room: Node2D, entryId: String)
@warning_ignore_restore("unused_signal")


func wait_for_sec(secs: float) -> void:
	await get_tree().create_timer(secs).timeout