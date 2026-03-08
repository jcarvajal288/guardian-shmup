class_name Bullet extends Area2D

var speed = 100.0
var direction = Vector2.DOWN
var damage = 1.0


func _ready() -> void:
	area_entered.connect(_on_area_entered)
	z_index = Global.RenderOrder.BULLET
	if direction == Global.TOWARDS_PLAYER:
		direction = (Global.player.global_position - global_position).normalized()


func _physics_process(delta: float) -> void:
	var displacement = speed * direction * delta	
	global_position += displacement


func _on_area_entered(area: Area2D) -> void:
	if area is Hurtbox:
		area.register_hit(damage)
		queue_free()
