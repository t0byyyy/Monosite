extends CharacterBody2D

# receives game start
var can_move
func _on_control_start_game() -> void:
	show()
	can_move = true

# jump logic - needs variable jump
const gravity = 300
var jump_power = 600
var x_accel = 100
var can_jump

func _physics_process(delta: float) -> void:
#	print(velocity.y)
# gravity
	if can_move == true:
		if not is_on_floor():
			velocity.y += gravity * delta

# handles jump, resets to base on floor
		if is_on_floor() and not Input.is_action_pressed("ui_accept"):
			can_jump = true
		if velocity.y <= -125 or is_on_ceiling() or Input.is_action_just_released("ui_accept") or velocity.y >= 15:
			can_jump = false
		if Input.is_action_pressed("ui_accept") and can_jump == true:
			velocity.y += -(jump_power*delta)
		if Input.is_action_just_pressed("ui_accept") and can_jump == true:
			velocity.y += -85
# handles directional inputs
		var direction := Input.get_axis("ui_left", "ui_right")

		if direction:
			velocity.x = direction * x_accel
		else:
			velocity.x = move_toward(velocity.x, 0, x_accel)

		move_and_slide()

# emits xpos for enemy tracking
	player_xpos.emit(position.x)

signal player_xpos(x)
