extends Node2D

@export var starting_room: PackedScene


func _ready() -> void:
	var room = starting_room.instantiate()
	$RoomManager.set_room(room)
