extends Sprite2D


func _process(_delta: float) -> void:
	var diff = Global.player.global_position - global_position
	if diff.x < 0 and diff.y > 0:
		flip_h = true
		flip_v = false
	elif diff.x > 0 and diff.y < 0:
		flip_h = false
		flip_v = true
	elif diff.x < 0 and diff.y < 0:
		flip_h = true
		flip_v = true
	else:
		flip_h = false
		flip_v = false
