extends Enemy

@export_enum("Left:1", "Right:-1") var move_direction: int = 1

@onready var ray_left = $RayCastPivot/RayCastLeft
@onready var ray_right = $RayCastPivot/RayCastRight
@onready var ray_move = $RayCastPivot/RayCastMove


func _ready() -> void:
	ray_left.add_exception(self)
	ray_right.add_exception(self)
	ray_move.add_exception(self)
	ray_move.rotation = deg_to_rad(90 * move_direction)


func _physics_process(_delta: float) -> void:
	if ray_move.is_colliding():
		var new_rotation = deg_to_rad(90 * move_direction)
		$RayCastPivot.rotate(new_rotation)
		velocity = velocity.rotated(new_rotation)
	if ray_left.is_colliding() or ray_right.is_colliding():
		var direction = (ray_move.to_global(ray_move.target_position) - ray_move.global_position).normalized()
		velocity = direction * GameStats.ANEMONE_SPEED
	else:
		var new_rotation = -deg_to_rad(90 * move_direction)
		$RayCastPivot.rotate(new_rotation)
		velocity = velocity.rotated(new_rotation)
	move_and_slide()
