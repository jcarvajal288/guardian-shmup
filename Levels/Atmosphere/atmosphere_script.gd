extends LevelScript

const BEETLE: PackedScene = preload("res://Actors/Beetle/Beetle.tscn")


func _ready() -> void:
    build_level()


func add_y(v: Vector2, y: float) -> Vector2:
    return Vector2(v.x, v.y + y)


func spawn_beetle(starting_point: Vector2, destination: Vector2) -> void:
    var beetle = BEETLE.instantiate()
    beetle.global_position = starting_point
    beetle.set_destination(destination)
    get_parent().add_child.call_deferred(beetle)


func build_level() -> void:
    # spawn_beetle(add_y(SPAWN_TOP_MIDDLE, 20), add_y(SPAWN_TOP_MIDDLE, 40))
    var p = SPAWN_TOP_MIDDLE
    # var p = Vector2(20,20)
    spawn_beetle(p, add_y(p, 40))