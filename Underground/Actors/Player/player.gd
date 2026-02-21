extends CharacterBody2D

@onready var animation_player = $AnimationPlayer

func _ready() -> void:
	$StateMachine.init(self)
	Global.player = self


func get_speed() -> float:
	return GameStats.PLAYER_WALK_SPEED


func flip_sprite(is_flipped: bool) -> void:
	$Sprite2D.flip_h = is_flipped


func _unhandled_input(event: InputEvent) -> void:
	$StateMachine.process_input(event)


func _physics_process(delta: float) -> void:
	$StateMachine.process_physics(delta)


func _process(delta: float) -> void:
	$StateMachine.process_frame(delta)
