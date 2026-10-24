extends Node2D

func _ready() -> void:
	Global.add_score.connect(_add_score)


func _add_score(amount: int) -> void:
	Global.score += amount
	$Label.text = "%09d" % Global.score