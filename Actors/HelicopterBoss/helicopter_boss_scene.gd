extends Node2D

func _ready() -> void:
	$StateMachine.init()
	$HelicopterBossA.check_for_phase_two.connect(_check_for_phase_two)
	$HelicopterBossB.check_for_phase_two.connect(_check_for_phase_two)
	$HelicopterBossC.check_for_phase_two.connect(_check_for_phase_two)


func _check_for_phase_two() -> void:
	var bosses_alive = [
		$HelicopterBossA.is_alive(),
		$HelicopterBossB.is_alive(),
		$HelicopterBossC.is_alive()
	]
	if bosses_alive.count(true) == 1:
		$StateMachine.change_state($StateMachine/Phase2)
	elif bosses_alive.count(true) <= 0:
		Global.transition_level.emit(3, 3.0)
