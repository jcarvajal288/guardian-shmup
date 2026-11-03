extends Node2D

@export var bullet_type: PackedScene
@export var direction = Global.TOWARDS_PLAYER
@export var speed = 100.0
@export var startup_time = 1.0
@export var repeat_time = 1.0
@export var separation_time = 0.1
@export var num_bullets = Global.INFINITE

@export var damage = 1.0


func _ready() -> void:
	$StartupTimer.timeout.connect(begin)
	$RepeatTimer.timeout.connect(fire)
	$StartupTimer.start(startup_time)


func begin() -> void:
	while true:
		var target_direction = direction
		if direction == Global.TOWARDS_PLAYER:
			target_direction = global_position.direction_to(Global.player.global_position)
		var bullet_counter = num_bullets
		for i in bullet_counter:
			fire(target_direction)
			await Global.wait_for_sec(separation_time)
		await Global.wait_for_sec(repeat_time)


func fire(target_direction: Vector2) -> void:
	var bullet = bullet_type.instantiate()
	bullet.direction = target_direction
	bullet.speed = speed
	bullet.global_position = global_position
	bullet.damage = damage
	Global.add_node_to_level.emit(bullet)
