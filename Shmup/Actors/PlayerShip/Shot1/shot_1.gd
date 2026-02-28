extends Area2D

const SPEED = 300.0
const DAMAGE = 1

var direction: Vector2 = Vector2.UP


func _ready() -> void:
	z_index = Global.RenderOrder.SHOT
	area_entered.connect(_on_area_hit)


func _physics_process(delta: float) -> void:
	var displacement = SPEED * direction * delta	
	global_position += displacement


func _on_area_hit(area: Area2D) -> void:
	if area is Hurtbox:
		area.register_hit(DAMAGE)
		queue_free()
