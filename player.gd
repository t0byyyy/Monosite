extends CharacterBody2D

var can_move

var max_speed = 600
var accel = 9999
var friction = 9999
var input = Vector2.ZERO

var hp = 100
signal health_value
signal dead

func _on_control_start_game() -> void:
	show()
	can_move = true

func _physics_process(delta):
	player_movement(delta)

func get_input():
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return input.normalized()

func player_movement(delta):
	input = get_input()
	if can_move == true:
		if input == Vector2.ZERO:
			if velocity.length() > (friction * delta):
				velocity -= velocity.normalized() * (friction * delta)
			else:
				velocity = Vector2.ZERO
		else:
			velocity += (input * accel * delta)
			velocity = velocity.limit_length(max_speed)
	
	move_and_slide()

func hp_control():
	if hp <= 0:
		hp = 0
		dead.emit()
	else:
		health_value.emit()
	
	
	
