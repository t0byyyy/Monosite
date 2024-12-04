extends Timer

func _physics_process(delta: float) -> void:
	if slashing == true:
		start()
		slashing = false

# receives slash from player
var slashing = false
func _on_player_slash_down() -> void:
	slashing = true
func _on_player_slash_up() -> void:
	slashing = true
func _on_player_slash_horizontal(direction: Variant) -> void:
	slashing = true

signal slash_end
func _on_timeout() -> void:
	slash_end.emit()
	print("slash ended")
