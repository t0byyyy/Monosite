extends CharacterBody2D

# receives game start
var can_move
func _on_control_start_game() -> void:
	show()
	can_move = true

# jump logic - needs variable jump
const gravity = 200
const base_jump_power = 750
var jump_power = base_jump_power
var x_accel = 100

func _physics_process(delta: float) -> void:

# gravity
	if can_move == true:
		if not is_on_floor():
			velocity.y += gravity * delta

# handles jump, resets to base on floor
		if is_on_floor():
			jump_power = base_jump_power

		if is_on_floor() and Input.is_action_pressed("ui_accept"):
			velocity.y += -(jump_power*delta) - 100

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
