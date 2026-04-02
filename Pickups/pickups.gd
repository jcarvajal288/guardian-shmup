extends Node

const dispenser_scene: PackedScene = preload("res://Pickups/DeathDispenser/DeathDispenser.tscn")
const shield_pickup_scene: PackedScene = preload("res://Pickups/ShieldPickup/ShieldPickup.tscn")


func add_shield_pickup(subject: Enemy) -> void:
	var dispenser = dispenser_scene.instantiate()
	dispenser.subject = subject
	dispenser.pickup_scene = shield_pickup_scene
	subject.add_child(dispenser)
