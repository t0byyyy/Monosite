extends CharacterBody2D

var can_move

var JUMP_VELOCITY = -800
var SPEED = 400

var hp = 100
signal health_value(hp)
signal dead

func _on_control_start_game() -> void:
	show()
	can_move = true

func _physics_process(delta: float) -> void:
	if can_move == true:
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Handle jump.
		if Input.is_action_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
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
