class_name Enemy extends CharacterBody2D


func _init() -> void:
	z_index = Global.RenderOrder.ENEMY


func _ready() -> void:
	$Hurtbox.on_hit.connect($Health.take_damage)
	$Health.on_death.connect(_on_death)


func _on_death() -> void:
	pass


func handle_death(vfx_scene: PackedScene, sfx: Sounds.SoundEffect, score: int) -> void:
	var vfx = vfx_scene.instantiate()
	vfx.global_position = global_position
	Global.add_node_to_level.emit(vfx)
	Sounds.play_sound.emit(sfx, global_position)
	Global.add_score.emit(score)
	queue_free()