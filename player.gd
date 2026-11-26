extends Node2D

@export var bullet_scene: PackedScene
@onready var polygon_2d: Polygon2D = $Polygon2D
@onready var shot_sound: AudioStreamPlayer2D = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# print("Hello World!") 
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			shot_sound.play()
			_spawn_bullet()
			var tween = create_tween()
			tween.tween_property(polygon_2d, "position", Vector2.ZERO, 0.2).from(Vector2(-32, 0))


func _spawn_bullet() -> void:
	
	for i in range(1):
		var bullet = bullet_scene.instantiate()
		add_child(bullet)
		bullet.global_transform = global_transform 
		
		#bullet.global_rotation += (i * 25) * (PI / 180.0)
		#bullet.global_rotation_degrees += (i * 25.0)
		bullet.global_rotation += deg_to_rad(i * 25)
		bullet.apply_central_impulse(bullet.global_transform.x.normalized() * 1000.0)
