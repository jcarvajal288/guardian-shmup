extends Area2D

@export var target: Global.CollisionLayer = Global.CollisionLayer.PLAYER
@export var damage = 1.0

signal on_hitbox_triggered

func _ready() -> void:
	set_collision_mask_value(target, true)
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D) -> void:
	if area is Hurtbox:
		area.register_hit(damage)
	on_hitbox_triggered.emit()

