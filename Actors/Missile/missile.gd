extends Enemy

func _ready() -> void:
	super()
	$Hitbox.on_hitbox_triggered.connect(_on_death)
	$Hitbox.damage = GameStats.MISSILE_DAMAGE


func _on_death() -> void:
	handle_death(
		Effects.EXPLOSION_16x16, 
		Sounds.SoundEffect.LOW_EXPLOSION, 
		GameStats.MISSILE_SCORE
	)