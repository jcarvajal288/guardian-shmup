class_name BulletCleanup extends Area2D


func _ready() -> void:
	set_collision_mask_value(Global.CollisionLayer.BULLET, true)
	set_collision_mask_value(Global.CollisionLayer.SHOT, true)
	set_collision_mask_value(Global.CollisionLayer.PICKUP, true)
	area_entered.connect(cleanup)


func cleanup(area: Area2D) -> void:
	if area is not BulletCleanup:
		area.queue_free()
