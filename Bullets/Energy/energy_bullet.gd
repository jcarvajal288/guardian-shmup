extends Bullet

const TURN_RATE = 0.5
const LIFETIME = 6.0


func _ready() -> void:
	speed = 40
	direction = Global.TOWARDS_PLAYER
	$LifetimeTimer.timeout.connect(dissipate)
	$LifetimeTimer.start(LIFETIME)
	$AnimatedSprite2D.animation_finished.connect(_on_animation_finished)
	super()


func _physics_process(delta: float) -> void:
	var direction_to_player = (Global.player.global_position - global_position).normalized()
	var turn = direction.angle_to(direction_to_player) / TURN_RATE * delta
	direction = direction.rotated(turn)
	super(delta)


func dissipate() -> void:
	$AnimatedSprite2D.play("dissipate")
	$CollisionShape2D.disabled = true


func _on_animation_finished() -> void:
	if $AnimatedSprite2D.animation == 'dissipate':
		queue_free()