extends CharacterBody2D

var can_move = false
var x_speed = 15
var direction

func _physics_process(delta):

	move_and_slide()

	if !is_on_floor():
		velocity.y += 200

	if can_move == true:
		if player_xpos > position.x:
			direction = 1
		if player_xpos < position.x:
			direction = -1

		velocity.x = x_speed*direction

var player_xpos

func _on_player_player_xpos(x: Variant) -> void:
	player_xpos = x

func _on_control_start_game() -> void:
	can_move = true
	show()
