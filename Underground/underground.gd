extends Level

@export var starting_room: PackedScene


func _ready() -> void:
	super()
	var room = starting_room.instantiate()
	$RoomManager.set_room(room)
