extends AnimatedSprite2D

const time_to_fade = 3.0

var fading_out = false

func _ready() -> void:
	z_index = Global.RenderOrder.TOP
	Global.player.z_index = z_index + 1
	animation_finished.connect(start_fade_out)
	Sounds.play_sound.emit(Sounds.SoundEffect.BOSS_EXPLOSION_1, global_position)


func start_fade_out() -> void:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "modulate:a", 0.0, time_to_fade)
	tween.finished.connect(end_tween)


func end_tween() -> void:
	queue_free()
	Global.player.z_index =  Global.RenderOrder.PLAYER

