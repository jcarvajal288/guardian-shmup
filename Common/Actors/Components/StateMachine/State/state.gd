class_name State extends Node

@export var animation_name: String

var director: Director
var subject: CharacterBody2D
var signal_state_change

func enter() -> void:
	subject.animation_player.play("RESET")
	subject.animation_player.advance(0)
	subject.animation_player.play(animation_name)


func exit() -> void:
	pass


func process_input(_event: InputEvent) -> State:
	return null


func process_physics(_delta: float) -> State:
	return null


func process_frame(_delta: float) -> State:
	return null