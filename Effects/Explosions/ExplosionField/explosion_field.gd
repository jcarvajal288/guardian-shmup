extends Node2D

@export var dimensions: Vector2
@export var num_wave: int
@export var wave_delay: float


func _ready() -> void:
	$WaveDelayTimer.timeout.connect(start_wave)	
	$WaveDelayTimer.start(wave_delay)


func start_wave() -> void:
	for _i in num_wave:
		var explosion = Effects.EXPLOSION_8x8.instantiate()
		var half_dim = dimensions / 2
		var tl = global_position - half_dim
		var br = global_position + half_dim
		var pos = Vector2(
			Global.rng.randf_range(tl.x, br.x),
			Global.rng.randf_range(tl.y, br.y),
		)
		explosion.global_position = pos
		Global.add_node_to_level.emit(explosion)
