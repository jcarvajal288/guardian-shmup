extends Node2D

enum Phase {
	ENTERING,
	FIGHTING,
	DYING
}

var phase: Phase = Phase.ENTERING

const ENTER_SPEED = 10.0
const DYING_SPEED = 20.0

const DEATH_EXPLOSION: PackedScene = preload("res://Actors/EyeBoss/DeathExplosion/DeathExplosion.tscn")

func _ready() -> void:
	set_children_processing_mode(ProcessMode.PROCESS_MODE_DISABLED)
	$Hurtbox.on_hit.connect($Health._on_hit)
	$Hurtbox.on_hit.connect($Eye._on_hit)
	$Health.on_death.connect(_on_death)
	$Health.set_health(GameStats.EYE_BOSS_STARTING_HEALTH)


func set_children_processing_mode(mode: ProcessMode) -> void:
	for child in get_children():
		child.process_mode = mode


func _physics_process(delta: float) -> void:
	if phase == Phase.ENTERING and global_position.y >= 16.0:
		phase = Phase.FIGHTING
		set_children_processing_mode(ProcessMode.PROCESS_MODE_INHERIT)
	elif phase == Phase.ENTERING:
		global_position.y += ENTER_SPEED * delta
	elif phase == Phase.DYING:
		if global_position.y < 64.0:
			global_position.y += DYING_SPEED * delta
		else:
			explode()


func _on_death() -> void:
	set_children_processing_mode(ProcessMode.PROCESS_MODE_DISABLED)
	$Eye.process_mode = ProcessMode.PROCESS_MODE_INHERIT
	$Eye.start_dying()
	var explosion_field = Effects.EXPLOSION_FIELD.instantiate()
	explosion_field.dimensions = Vector2(128, 32)
	explosion_field.num_wave = 3
	explosion_field.wave_delay = 0.1
	add_child(explosion_field)
	phase = Phase.DYING
	Sounds.play_sound.emit(Sounds.SoundEffect.LONG_BOSS_EXPLOSION, global_position)


func explode():
	var explosion = DEATH_EXPLOSION.instantiate()
	explosion.global_position = global_position
	explosion.global_position.y += 8
	Global.add_node_to_level.emit(explosion)
	await Global.wait_for_sec(0.5)
	queue_free()
