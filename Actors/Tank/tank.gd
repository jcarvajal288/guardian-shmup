extends Enemy

@onready var firing_angle_for_octant = [
	[Vector2.RIGHT, $TurretSprite/FirePointRight],
	[Vector2(1, 1), $TurretSprite/FirePointDownRight],
	[Vector2.DOWN, $TurretSprite/FirePointDown],
	[Vector2(-1, 1), $TurretSprite/FirePointDownLeft],
	[Vector2.LEFT, $TurretSprite/FirePointLeft],
	[Vector2(-1, -1), $TurretSprite/FirePointUpLeft],
	[Vector2.UP, $TurretSprite/FirePointUp],
	[Vector2(-1, 1), $TurretSprite/FirePointUpRight]
]

func _ready() -> void:
	super()
	velocity = Vector2(0, 0)
	if velocity.y > 0: # 0 will need to be the scrolling speed of the background eventually
		$BodyAnimatedSprite.play("move")
	elif velocity.y < 0:
		$BodyAnimatedSprite.play_backwards("move")
	else:
		$BodyAnimatedSprite.pause()


func _process(_delta: float) -> void:
	var player_angle = (Global.player.global_position - global_position).angle()
	var clamped_angle = player_angle / (PI / 4.0)
	var octant = posmod(int(round(clamped_angle)), 8)
	$TurretSprite.frame = octant
	$FireLine.direction = firing_angle_for_octant[octant][0]
	$FireLine.global_position = firing_angle_for_octant[octant][1].global_position
	move_and_slide()


func _on_death() -> void:
	handle_death(
		Effects.EXPLOSION_16x16, 
		Sounds.SoundEffect.SMALL_EXPLOSION_2, 
		GameStats.TANK_SCORE
	)