extends Node2D


func _ready() -> void:
	$CanvasLayer/VBoxContainer/ScoreLabel.text = "%09d" % Global.score


func _process(_delta: float) -> void:
	if Input.is_action_pressed("start"):
		Global.reset.emit()
