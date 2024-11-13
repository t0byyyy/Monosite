extends Area2D

var colliding
signal touching_slime()
func _physics_process(delta: float) -> void:
	if colliding == true:
		touching_slime.emit()

func _on_area_entered(area: Area2D) -> void:
	colliding = true

func _on_area_exited(area: Area2D) -> void:
	colliding = false
