class_name Player extends CharacterBody2D

@onready var animation_player = $AnimationPlayer

func _ready() -> void:
	$StateMachine.init(self)
	Global.player = self
	z_index = Global.RenderOrder.PLAYER
	$Health.set_health(GameStats.PLAYER_STARTING_HEALTH)
	Global.player_health_changed.emit($Health.current_health, $Health.max_health)


func get_speed() -> float:
	return GameStats.PLAYER_WALK_SPEED


func take_damage(damage: float) -> void:
	$Health.take_damage(damage)
	Global.player_health_changed.emit($Health.current_health, $Health.max_health)


func flip_sprite(is_flipped: bool) -> void:
	$Sprite2D.flip_h = is_flipped


func _unhandled_input(event: InputEvent) -> void:
	$StateMachine.process_input(event)


func _physics_process(delta: float) -> void:
	$StateMachine.process_physics(delta)


func _process(delta: float) -> void:
	$StateMachine.process_frame(delta)
