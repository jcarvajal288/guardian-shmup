class_name Enemy extends CharacterBody2D


func _init() -> void:
	z_index = Global.RenderOrder.ENEMY
	set_collision_layer_value(1, false)
	set_collision_layer_value(2, true)
	set_collision_mask_value(1, false)


func _ready() -> void:
	$Hurtbox.on_hit.connect(_on_hit)
	$Hurtbox.on_hit.connect($Health.take_damage)
	$Health.on_death.connect(_on_death)


func _on_death() -> void:
	pass


func _on_hit(_dmg: float) -> void:
	if $Health.max_health > 1:
		var hit = Effects.EXPLOSION_8x8_2.instantiate()
		var size = $CollisionShape2D.shape.radius
		var x = Global.rng.randf_range(-size / 2, size / 2)
		var y = Global.rng.randf_range(-size / 2, size / 2)
		hit.global_position = global_position + Vector2(x, y)
		Global.add_node_to_level.emit(hit)


func handle_death(vfx_scene: PackedScene, sfx: Sounds.SoundEffect, score: int) -> void:
	var vfx = vfx_scene.instantiate()
	vfx.global_position = global_position
	Global.add_node_to_level.emit(vfx)
	Sounds.play_sound.emit(sfx, global_position)
	Global.add_score.emit(score)
	queue_free()