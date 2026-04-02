extends Node2D

@export var pickup_scene: PackedScene
@export var subject: CharacterBody2D


func _ready() -> void:
	var health = subject.get_node_or_null("Health")
	if health:
		health.on_death.connect(dispense_pickup)
	else:
		push_warning("No Health node found on Enemy ", subject.name)


func dispense_pickup() -> void:
	var pickup = pickup_scene.instantiate()	
	pickup.global_position = subject.global_position
	Global.add_node_to_level.emit.call_deferred(pickup)