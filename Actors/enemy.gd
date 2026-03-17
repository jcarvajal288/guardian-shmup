class_name Enemy extends CharacterBody2D


func _init() -> void:
	z_index = Global.RenderOrder.ENEMY


func _ready() -> void:
	$Hurtbox.on_hit.connect($Health.take_damage)
