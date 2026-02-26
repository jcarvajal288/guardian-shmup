extends Enemy

@onready var ray_left = $RayCastPivot/RayCastLeft
@onready var ray_right = $RayCastPivot/RayCastRight


func _ready() -> void:
	ray_left.add_exception(self)
	ray_right.add_exception(self)


func _physics_process(_delta: float) -> void:
	if ray_left.is_colliding() or ray_right.is_colliding():
		var direction = ray_left.get_collision_normal().orthogonal()
		velocity = direction * GameStats.ANEMONE_SPEED
	else:
		var new_rotation = -deg_to_rad(90)
		$RayCastPivot.rotate(new_rotation)
		velocity = velocity.rotated(new_rotation)
	move_and_slide()