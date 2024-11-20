extends Control

signal start_game()

#func _ready():
	#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
			get_tree().quit()

func _on_button_pressed() -> void:
	start_game.emit()
	hide()

func _on_button_2_pressed() -> void:
	get_tree().quit()
