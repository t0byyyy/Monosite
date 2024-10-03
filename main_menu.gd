extends Control

signal start_game()

func _on_button_pressed() -> void:
	start_game.emit()
	hide()

func _on_button_2_pressed() -> void:
	get_tree().quit()
