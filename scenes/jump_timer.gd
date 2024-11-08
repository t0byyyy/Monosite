extends Timer

signal jump
func _on_timeout() -> void:
	jump.emit()
