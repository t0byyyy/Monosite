extends CharacterBody2D

var can_move
var SPEED = 100

const gravity = 200

# jump logic
var jumps_available = 2
const total_jump_power = 1000
const jump_deceleration = 1200
var jump_power = total_jump_power

var hp = 100
signal health_value(hp)
signal dead

func _on_control_start_game() -> void:
	show()
	can_move = true

func _physics_process(delta: float) -> void:
	if can_move == true:
		if not is_on_floor():
			velocity.y += gravity * delta

		# Handle jump.
		if jumps_available != 2 and is_on_floor():
			jumps_available = 2
			jump_power = total_jump_power

		if Input.is_action_pressed("ui_accept"):

			velocity.y += -(jump_power*delta)
			jump_power = jump_power - (jump_deceleration * delta)
					
		if Input.is_action_just_released("ui_accept"):
			jumps_available -= 1

		var direction := Input.get_axis("ui_left", "ui_right")

		if direction:
			velocity.x = direction * SPEED
		else:
				velocity.x = move_toward(velocity.x, 0, SPEED)

		move_and_slide()

func hp_control():
	if hp <= 0:
		hp = 0
		dead.emit()
	else:
		health_value.emit()
