extends CharacterBody2D

@onready var right_generator: CharacterBody2D = $RightGenerator
@onready var left_generator: CharacterBody2D = $LeftGenerator
@onready var energy: AnimatedSprite2D = $Energy

func _ready() -> void:
	velocity = Vector2(0, 20)
	right_generator.generator_died.connect(handle_generator_dying)
	left_generator.generator_died.connect(handle_generator_dying)


func _process(_delta: float) -> void:
	move_and_slide()


func handle_generator_dying() -> void:
	if is_instance_valid(energy):
		energy.queue_free() # TODO: put an effect here
	if is_instance_valid(right_generator):
		right_generator.deactivate()
	if is_instance_valid(left_generator):
		left_generator.deactivate()