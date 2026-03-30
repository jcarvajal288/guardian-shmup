extends Area2D


func _ready() -> void:
	set_collision_mask_value(Global.CollisionLayer.ENEMY, true)
	body_exited.connect(cleanup)


func cleanup(body: Node2D) -> void:
	body.queue_free()