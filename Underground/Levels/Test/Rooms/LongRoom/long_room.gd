extends Room


func get_entry_point(entry_id: String) -> Vector2:
	if entry_id == "WesternExit":
		return $WesternExit/PlayerEntryPoint.global_position
	else:
		assert(false, "Invalid entry_id for BigRoom: %s" % entry_id)
		return Vector2.ZERO
