extends Node2D

const EYE_LOOK_DOWN = 0
const EYE_LOOK_LEFT = 1
const EYE_LOOK_RIGHT = 2
const EYE_LOOK_DOWN_DMG = 3
const EYE_LOOK_LEFT_DMG = 4
const EYE_LOOK_RIGHT_DMG = 5

const FRAME_BOUNDARY_LEFT = 57
const FRAME_BOUNDARY_RIGHT = 103

const dying_eye_move_threshold = 0.2

@onready var is_damage_flashing = false
@onready var is_dying = false
@onready var dying_eye_move_counter = 0
@onready var dying_eye_move_index = 0
@onready var dying_eye_move_frames = [
	EYE_LOOK_LEFT,
	EYE_LOOK_DOWN,
	EYE_LOOK_RIGHT,
	EYE_LOOK_DOWN,
]

func _ready() -> void:
	$EyeSprite.frame = EYE_LOOK_DOWN
	$FireArc.damage = GameStats.EYE_BOSS_EYE_BULLET_DAMAGE


func _process(delta: float) -> void:
	if not is_dying:
		normal_eye_movement()
	else:
		dying_eye_movement(delta)


func normal_eye_movement() -> void:
	var player_pos_x = Global.player.global_position.x
	if player_pos_x < FRAME_BOUNDARY_LEFT:
		if is_damage_flashing:
			$EyeSprite.frame = EYE_LOOK_LEFT_DMG
		else:
			$EyeSprite.frame = EYE_LOOK_LEFT
		$FireArc.global_position = $FireLeft.global_position
	elif player_pos_x > FRAME_BOUNDARY_RIGHT:
		if is_damage_flashing:
			$EyeSprite.frame = EYE_LOOK_RIGHT_DMG
		else:
			$EyeSprite.frame = EYE_LOOK_RIGHT
		$FireArc.global_position = $FireRight.global_position
	else:
		if is_damage_flashing:
			$EyeSprite.frame = EYE_LOOK_DOWN_DMG
		else:
			$EyeSprite.frame = EYE_LOOK_DOWN
		$FireArc.global_position = $FireDown.global_position


func dying_eye_movement(delta: float) -> void:
	dying_eye_move_counter += delta
	if dying_eye_move_counter >= dying_eye_move_threshold:
		dying_eye_move_index += 1
		if dying_eye_move_index >= dying_eye_move_frames.size():
			dying_eye_move_index = 0
		$EyeSprite.frame = dying_eye_move_frames[dying_eye_move_index]
		dying_eye_move_counter = 0


func _on_hit(_damage: float) -> void:
	damage_flash()
	Sounds.play_sound.emit(Sounds.SoundEffect.BOSS_HIT, global_position)

	var hit = Effects.EXPLOSION_8x8_2.instantiate()
	var size = $EyeSprite.get_rect().size
	var x = Global.rng.randf_range(-size.x / 2, size.x / 2)
	var y = Global.rng.randf_range(-size.y / 2, size.y / 2)
	hit.global_position = global_position + Vector2(x, y)
	Global.add_node_to_level.emit(hit)


func damage_flash() -> void:
	is_damage_flashing = true
	await Global.wait_for_sec(0.1)
	is_damage_flashing = false


func start_dying() -> void:
	is_dying = true
	$EyeSprite.flip_v = true
	$FireArc.process_mode =  ProcessMode.PROCESS_MODE_DISABLED
