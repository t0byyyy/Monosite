extends CharacterBody2D

var can_move
func _on_control_start_game() -> void:
	show()
	can_move = true

var dead = false
signal death

func hp_control():
	if dead == true:
		death.emit()

# jump logic
var jumps_available = 1
const total_jump_power = 750
const jump_deceleration = 1200
var jump_power = total_jump_power
const gravity = 200
var x_accel = 100

func _physics_process(delta: float) -> void:
	if can_move == true:
		if not is_on_floor():
			velocity.y += gravity * delta

		# Handle jump.
		if jumps_available != 1 and is_on_floor():
			jumps_available = 1
			jump_power = total_jump_power

		if jumps_available > 0 and Input.is_action_pressed("ui_accept"):
			if velocity.x != 0:
				velocity.y += -(jump_power*delta) - 100 - abs(velocity.x / 7)
				jump_power = jump_power - (jump_deceleration * delta)
				jumps_available = 0
			else:
				velocity.y += -(jump_power*delta) - 100
				jump_power = jump_power - (jump_deceleration * delta)
				jumps_available = 0

		var direction := Input.get_axis("ui_left", "ui_right")

		if direction:
			velocity.x = direction * x_accel
		else:
			velocity.x = move_toward(velocity.x, 0, x_accel)

		move_and_slide()

	player_xpos.emit(position.x)

signal player_xpos(x)
