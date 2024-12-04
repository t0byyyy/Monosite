extends Area2D



func _on_slash_end() -> void:
	pass # Replace with function body.


func _on_player_slash_horizontal(direction: Variant) -> void:
	if direction == -1:
		scale.x = -1
	if direction == 1:
		scale.x = 1
