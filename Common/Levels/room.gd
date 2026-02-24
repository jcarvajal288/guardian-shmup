class_name Room extends Node2D


const MAP_TILE_SIZE = 8

func _ready() -> void:
	var room_rect = $TileMapBackground.get_used_rect()
	var pos = room_rect.position * MAP_TILE_SIZE
	var size = room_rect.size * MAP_TILE_SIZE

	Global.bind_camera.emit(Rect2(pos, size))


func get_entry_point(_entry_id: String) -> Vector2:
	return Vector2.ZERO
