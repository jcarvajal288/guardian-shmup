extends Area2D

@export var next_room_path: String
@export var entry_id: String


func _ready() -> void:
	body_entered.connect(_body_entered)


func _body_entered(body: Node2D) -> void:
	if body is Player:
		Global.transition_room.emit(next_room_path, entry_id)