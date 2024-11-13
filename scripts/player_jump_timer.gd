extends Timer

signal jump_timeout
signal jump_begin
var can_jump = true

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_accept") and can_jump == true:
		start()
		jump_begin.emit()
	if Input.is_action_just_released("ui_accept"):
		stop()
		jump_timeout.emit()
func _on_timeout() -> void:
	jump_timeout.emit()
func _on_jump_timeout() -> void:
	can_jump = false
