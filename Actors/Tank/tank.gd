extends Enemy


func _ready() -> void:
	velocity = Vector2(0, 25)
	if velocity.y > 0: # 0 will need to be the scrolling speed of the background eventually
		$BodyAnimatedSprite.play("move")
	elif velocity.y < 0:
		$BodyAnimatedSprite.play_backwards("move")
	else:
		$BodyAnimatedSprite.pause()


func _process(_delta: float) -> void:
	move_and_slide()
