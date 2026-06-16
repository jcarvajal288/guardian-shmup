extends Node

@export var subjectA: CharacterBody2D
@export var subjectB: CharacterBody2D
@export var subjectC: CharacterBody2D
@export var starting_state: HelicopterState

var current_state: HelicopterState

signal signal_state_change

func init() -> void:
	for child in get_children():
		child.subjectA = subjectA
		child.subjectB = subjectB
		child.subjectC = subjectC
		child.signal_state_change = signal_state_change
	change_state(starting_state)
	signal_state_change.connect(change_state)


func change_state(new_state: HelicopterState) -> void:
	if new_state == current_state:
		return
	if current_state:
		current_state.exit()
	current_state = new_state
	current_state.enter()


func _unhandled_input(event: InputEvent) -> void:
	if not current_state:
		return
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)


func _physics_process(delta: float) -> void:
	if not current_state:
		return
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)


func _process(delta: float) -> void:
	if not current_state:
		return
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)
