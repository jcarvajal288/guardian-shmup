extends CharacterBody2D

var movement_pattern: Node = null

var has_stopped_moving: bool = false


func _ready() -> void:
	$Hurtbox.on_hit.connect($Health.take_damage)
	$Health.on_death.connect(_on_death)


func change_movement_pattern(new_pattern: Node) -> void:
	if movement_pattern != null:
		movement_pattern.queue_free()
	movement_pattern = new_pattern
	add_child(movement_pattern)
	movement_pattern.start_moving()
	has_stopped_moving = false
	movement_pattern.stopped_moving.connect(_on_stopped_moving)


func _on_stopped_moving() -> void:
	has_stopped_moving = true


func _on_death() -> void:
	$Sprite2D.visible = false
	$Hurtbox.set_deferred("monitoring", false)
	$Hurtbox.set_deferred("monitorable", false)
	$Hitbox.set_deferred("monitoring", false)
	$Hitbox.set_deferred("monitorable", false)