extends CharacterBody2D

var can_move = false
var x_speed = 15
var direction
const gravity = 200

func _physics_process(delta: float) -> void:

	if !is_on_floor():
		velocity.y += gravity * delta

	if player_xpos - position.x <= 100:
		if can_move == true:
			if player_xpos > position.x:
				direction = 1
			if player_xpos < position.x:
				direction = -1
			move_and_slide()
			velocity.x = x_speed*direction

func _on_jump_timer_jump() -> void:
	if can_move == true and is_on_floor():
		velocity.y = -65

var player_xpos

func _on_player_player_xpos(x: Variant) -> void:
	player_xpos = x

func _on_control_start_game() -> void:
	can_move = true
	show()
