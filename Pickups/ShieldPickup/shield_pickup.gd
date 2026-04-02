extends AnimatedSprite2D

func _ready() -> void:
	$Area2D.body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body is PlayerShip:
		body.add_shield(1.0)
		Sounds.play_sound.emit(Sounds.SoundEffect.SHIELDS_UP, global_position)
		queue_free()