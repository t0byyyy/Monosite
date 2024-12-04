extends CollisionPolygon2D


func _on_player_slash_horizontal(direction: Variant) -> void:
	position.x = 5 * direction
	scale.x = 1 * direction
