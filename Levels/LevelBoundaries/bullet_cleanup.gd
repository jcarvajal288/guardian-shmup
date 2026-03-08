extends Area2D


func _ready() -> void:
	set_collision_mask_value(Global.CollisionLayer.BULLET, true)
	set_collision_mask_value(Global.CollisionLayer.SHOT, true)
	area_entered.connect(cleanup)


func cleanup(area: Area2D) -> void:
	area.queue_free()
