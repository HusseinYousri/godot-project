extends RigidBody2D
@onready var polygon_2d: Polygon2D = $Polygon2D
@onready var trail_pivot: Node2D = $TrailPivot

@export var fade_speed: float = 1.0
var start_fading := false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	trail_pivot.scale.x += delta * 1.0
	
	if not linear_velocity.is_zero_approx():
		var travel_angle := linear_velocity.angle()
		polygon_2d.global_rotation = travel_angle
		trail_pivot.global_rotation = travel_angle
	
	if start_fading:
		modulate.a = move_toward(modulate.a, 0.0, delta / fade_speed)


func _on_timer_timeout() -> void:
	var tween = create_tween()
	start_fading = true
	#tween.tween_property(self, "modulate", Color(1,.25,.25,0), 1).from(Color.WHITE)
	await get_tree().create_timer(2.0).timeout
	queue_free()
