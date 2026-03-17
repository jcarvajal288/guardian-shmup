extends Sprite2D


func _ready() -> void:
	z_index = Global.RenderOrder.ENEMY + 1


func _physics_process(_delta: float) -> void:
	var angle = (Global.player.global_position - global_position).angle()
	var octant = posmod(int(round(angle / (PI / 4.0))), 8)
	frame = octant
