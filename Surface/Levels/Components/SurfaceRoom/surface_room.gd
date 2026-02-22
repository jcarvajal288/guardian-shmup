class_name SurfaceRoom extends Node2D

const MAP_TILE_SIZE = 16


func rect() -> Rect2:
	var tile_room_size = $TileMapFloor.get_used_rect().size
	var pixel_room_size = Vector2(
		tile_room_size.x * MAP_TILE_SIZE,
		tile_room_size.y * MAP_TILE_SIZE,
	)
	return Rect2(global_position, pixel_room_size)
