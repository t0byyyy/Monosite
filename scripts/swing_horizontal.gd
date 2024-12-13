extends Area2D

func _on_slash_end() -> void:
	set_monitoring(false)
	set_monitorable(false)

func _on_player_slash_horizontal(direction: Variant) -> void:
	if direction == -1:
		scale.x = -1
	elif direction == 1:
		scale.x = 1
	set_monitoring(true)
	set_monitorable(true)
