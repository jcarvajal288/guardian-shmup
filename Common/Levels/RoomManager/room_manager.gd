extends Node

var current_room: Room


func _ready() -> void:
	Global.transition_room.connect(_transition_room)


func _transition_room(next_room_path: String, entry_id: String) -> void:
	current_room.queue_free()
	var room = load(next_room_path).instantiate()
	current_room = room
	call_deferred("add_child", room)
	Global.player.global_position = room.get_entry_point(entry_id)


func set_room(room: Room) -> void:
	current_room = room
	add_child(room)
