extends Area2D



func _on_slash_end() -> void:
	pass # Replace with function body.

var slashing
func _on_player_slash_horizontal(direction: Variant) -> void:
	slashing = true
	if direction == -1 and !slashing == false:
		scale.x = -1
		slashing = false
	elif direction == 1 and !slashing == false:
		scale.x = 1
		slashing = false


func _on_area_entered(area: Area2D) -> void:
	print("boobs")
