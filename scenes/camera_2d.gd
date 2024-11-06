extends Camera2D

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("zoomin"):
		set_zoom(Vector2(4, 4))
	if Input.is_action_just_pressed("zoomin"):
		set_zoom(Vector2(-4, -4))
