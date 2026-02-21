extends Node2D

const MAP_TILE_SIZE = 8


func _ready() -> void:
	var room_rect_size = $TileMapLayer.get_used_rect().size
	var pixel_room_size = Vector2(
		room_rect_size.x * MAP_TILE_SIZE,
		room_rect_size.y * MAP_TILE_SIZE,
	)
	Global.bind_camera.emit(Rect2(global_position, pixel_room_size))