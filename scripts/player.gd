extends CharacterBody2D

# receives game start
var can_move
func _on_control_start_game() -> void:
	show()
	can_move = true

# jump logic - needs variable jump
const gravity = 400
var jump_power = 600
var x_accel = 100
var can_jump
var dashing

func _physics_process(delta: float) -> void:
	print(velocity.x, " ", velocity.y)
# gravity
	if can_move == true:
		if not is_on_floor() and velocity.y <= 600:
			velocity.y += gravity * delta

# handles jump, resets to base on floor
		if is_on_floor() and !Input.is_action_pressed("ui_accept"):
			can_jump = true
		if velocity.y <= -135 or is_on_ceiling() or Input.is_action_just_released("ui_accept") or velocity.y >= 15:
			can_jump = false
		if Input.is_action_pressed("ui_accept") and can_jump == true:
			velocity.y += -(jump_power * delta)
		if Input.is_action_just_pressed("ui_accept") and can_jump == true:
			velocity.y += -95

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

var origin = Vector2(0, 0)
#handles death, remember to add Area2Ds with 2,2 collisions to interact with this
func _on_area_2d_area_entered(area: Area2D) -> void:
	self.position = origin

func death():
	can_move = false


#if Input.is_action_just_pressed("run"):
	#dashing = true

if dashing == true:
	
