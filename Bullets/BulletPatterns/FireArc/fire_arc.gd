extends Node2D

@export var bullet_type: PackedScene
@export var direction = Global.TOWARDS_PLAYER
@export var speed = 100.0
@export var startup_time = 1.0
@export var repeat_time = 1.0

@export var arc: float
@export var bullets_in_arc: int

@export var damage = 1.0


func _ready() -> void:
	$StartupTimer.timeout.connect(begin)
	$RepeatTimer.timeout.connect(fire)
	$StartupTimer.start(startup_time)


func begin() -> void:
	fire()
	$RepeatTimer.start(repeat_time)


func fire() -> void:
	var start 
	var arc_rads = deg_to_rad(arc)
	if direction == Global.TOWARDS_PLAYER:
		start = (Global.player.global_position - global_position).angle() - arc_rads / 2.0
	else:
		start = direction.angle() - arc_rads / 2.0
	if bullets_in_arc < 2:
		bullets_in_arc = 2
	var step = arc_rads / float(bullets_in_arc - 1)
	var angles = range(bullets_in_arc).map(func(i):
		return start + i * step
	)
	for angle in angles:
		var bullet = bullet_type.instantiate()
		bullet.direction = Vector2.from_angle(angle)
		bullet.speed = speed
		bullet.global_position = global_position
		Global.add_node_to_level.emit(bullet)

	$RepeatTimer.start(repeat_time)
