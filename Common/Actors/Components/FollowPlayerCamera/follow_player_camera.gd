extends Camera2D


func _ready() -> void:
	Global.bind_camera.connect(bind_to_rect)


func bind_to_rect(rect: Rect2) -> void:
	limit_top = int(rect.position.y)
	limit_bottom = int(rect.end.y)
	limit_left = int(rect.position.x)
	limit_right = int(rect.end.x)


func _process(_delta: float) -> void:
	if Global.player != null:
		global_position = Global.player.global_position
