class_name Level extends Node2D


func _ready() -> void:
	Global.add_node_to_level.connect(add_child)