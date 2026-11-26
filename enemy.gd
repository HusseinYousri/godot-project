extends Area2D

@onready var polygon_2d: Polygon2D = $Polygon2D
@onready var pop_sound: AudioStreamPlayer2D = $AudioStreamPlayer2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotation_degrees = randf_range(0, 360)
	polygon_2d.color.s = 0.5
	polygon_2d.color.h = randf()
	
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ONE, .1).from(Vector2(1.5, 1.5))


func _on_body_entered(body: Node2D) -> void:
	if body is RigidBody2D:
		body.queue_free()
		_on_bullet_hit()
		await get_tree().create_timer(0.05).timeout
		queue_free()

func _on_bullet_hit() -> void:
	polygon_2d.color = Color.DARK_RED # Bullet turns red before killed
	scale = scale * 1.25 # 25% more scale on bullet hit
	collision_mask = 0 # disable collisions upon hit
	pop_sound.play()
