extends LevelScript

const BEETLE: PackedScene = preload("res://Actors/Beetle/Beetle.tscn")


func _ready() -> void:
    var starting_point = Vector2(20, 20)
    var destination = Vector2(20, 80)
    spawn_beetle(starting_point, destination)


func spawn_beetle(starting_point: Vector2, destination: Vector2) -> void:
    var beetle = BEETLE.instantiate()
    beetle.global_position = starting_point
    beetle.set_destination(destination)
    get_parent().add_child.call_deferred(beetle)