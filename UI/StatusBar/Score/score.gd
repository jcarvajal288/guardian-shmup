extends Node2D

@onready var score = 0

func _ready() -> void:
	Global.add_score.connect(_add_score)


func _add_score(amount: int) -> void:
	score += amount
	$Label.text = "%09d" % score