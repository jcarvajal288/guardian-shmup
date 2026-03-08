extends Node2D

@export var bullet_type: PackedScene
@export var direction = Global.TOWARDS_PLAYER
@export var speed = 100.0
@export var startup_time = 1.0
@export var repeat_time = 1.0
@export var num_bullets = Global.INFINITE

@export var damage = 1.0


func _ready() -> void:
	$StartupTimer.timeout.connect(begin)
	$RepeatTimer.timeout.connect(fire)
	$StartupTimer.start(startup_time)


func begin() -> void:
	fire()
	$RepeatTimer.start(repeat_time)


func fire() -> void:
	var bullet = bullet_type.instantiate()
	bullet.direction = direction
	bullet.speed = speed
	bullet.global_position = global_position
	bullet.damage = damage
	Global.add_node_to_level.emit(bullet)

	if num_bullets > 0:
		num_bullets -= 1
		$RepeatTimer.start(repeat_time)

