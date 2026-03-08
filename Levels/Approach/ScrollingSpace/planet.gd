extends Sprite2D

const TIME_TO_COMPLETE = 60.0

var time_to_move_a_pixel = 0.0

var elapsed_time = 0.0


func _ready() -> void:
	var distance = 144
	time_to_move_a_pixel = TIME_TO_COMPLETE / distance	


func _process(delta: float) -> void:
	elapsed_time += delta
	if global_position.y <= 72 and elapsed_time > time_to_move_a_pixel:
		global_position.y += 1
		elapsed_time = 0.0
