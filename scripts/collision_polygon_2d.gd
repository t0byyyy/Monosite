extends CollisionPolygon2D

func _on_player_slash_horizontal(direction: Variant) -> void:
	if direction:
		position.x = 5
	set_disabled(false)


func _on_swing_timer_slash_end() -> void:
	set_disabled(true)
